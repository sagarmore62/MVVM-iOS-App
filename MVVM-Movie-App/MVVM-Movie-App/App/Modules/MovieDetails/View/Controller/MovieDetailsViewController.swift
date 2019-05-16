//
//  MovieDetailsViewController.swift
//  MVVM-Movie-App
//
//  Created by Sagar More on 15/05/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblOverview : UILabel!
    @IBOutlet weak var lblReleaseData : UILabel!
    
    var viewModel : MovieDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let _ = viewModel else {
            fatalError("view model should be defined")
        }
        setUpUI()
    }
    
    private func setUpUI() {
        if let img = viewModel.imagePath {
            imgView.getImageWith(img)
        }
        lblName.attributedText = viewModel.description
        lblOverview.attributedText = viewModel.overview
        lblReleaseData.attributedText = viewModel.releaseData
    }

}
