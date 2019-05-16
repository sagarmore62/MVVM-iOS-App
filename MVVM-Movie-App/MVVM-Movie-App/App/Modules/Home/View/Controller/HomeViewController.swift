//
//  ViewController.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

// MARK: - This controller is used to show both screen Movie search & favourite movie.
// isFavourite flag handles switching between both
class HomeViewController: UIViewController {

    let cellIdentifier = "MovieListCollectionViewCell"
    private let padding : CGFloat = 8.0
    private let movieLabelHeight : CGFloat = 25.0
    var viewModel : MovieViewModel!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var searchField : UITextField!
    @IBOutlet var heightConstraint : NSLayoutConstraint!
    @IBOutlet weak var errorMessage : UILabel!
    var isFavourite = false //flag to define movie listing or favourite movie screen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setUpViewModel()
        setUpSearchField()
        setUpScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFavourite {
            //favourite screen will update it's data every time on view appear
            viewModel.getMovies(isFavourite)
        } else {
            //to get updated wishlist product status
            collectionView.reloadData()
        }
    }
    
    private func setUpScreen() {
        errorMessage.text  = viewModel.getErrorMessage(isFavourite)
        let tabBar = self.tabBarController?.tabBar
        tabBar?.tintColor = .red
        tabBar?.barTintColor = .white
    }
    
    private func setUpSearchField() {
        guard !isFavourite else {
            heightConstraint.constant = 0
            return
        }
        searchField.delegate = self
        searchField.addTarget(self, action: #selector(textFieldTextChanged(_:)), for: .editingChanged)
        //left padding to textfield
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height:searchField.frame.size.height))
        searchField.leftView = paddingView
        searchField.leftViewMode = .always
        //round shape to search field
        searchField.layer.borderColor = UIColor.gray.cgColor
        searchField.layer.borderWidth = 1.0
        searchField.layer.cornerRadius = searchField.bounds.size.height / 2
    }
    
    private func setUpViewModel() {
        viewModel = MovieViewModel()
        viewModel.delegate = self
        if !isFavourite {
            viewModel.getMovies(isFavourite)
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.scrollDirection = .vertical
        flowLayout?.minimumLineSpacing = padding
        flowLayout?.minimumInteritemSpacing = padding
        flowLayout?.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        let cellWidth = (view.bounds.size.width - (padding * 3)) / 2 //( device width - padding between cell ) / 2
        let cellHeight = (cellWidth * 1.5) + 40.0 // cell width * 1.5 + movie lable height
        flowLayout?.itemSize = CGSize(width: cellWidth , height: cellHeight)
    }

}

// MARK: - Movie View Model delegate methods
extension HomeViewController : MovieViewModelProtocol {
    func onWishlistUpdate(_ indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func apiErrorUpdated(_ error: Error?) {
        print(error)
    }
    
    func movieListUpdated() {
        DispatchQueue.main.async {
            self.errorMessage.isHidden = true
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
        }
    }
    
    func emptyResult() {
        DispatchQueue.main.async {
            self.errorMessage.isHidden = false
        }
    }
    
    @objc func onWishlistClicked(_ sender : UIButton) {
        let tag = sender.tag
        viewModel.wishlistUpdateWith(IndexPath(item: tag, section: 0), isFavourite: isFavourite)
    }
}

// MARK: - textfield text change methods
extension HomeViewController : UITextFieldDelegate{
    @objc func textFieldTextChanged(_ textField : UITextField) {
        //binding view model variable with textfield
        viewModel.searchText = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

