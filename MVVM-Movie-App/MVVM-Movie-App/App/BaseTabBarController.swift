//
//  BaseTabBarController.swift
//  MVVM-Movie-App
//
//  Created by Sagar More on 14/05/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild()
    }
    
    ///Adds child view controller to tab bar controller
    private func addChild() {
        let home = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.home) as? HomeViewController
        home?.title = Constants.PageTitle.movies

        let favourite = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.home) as? HomeViewController
        favourite?.title = Constants.PageTitle.favourite
        favourite?.isFavourite = true
        
        guard let homeVC = home, let favouriteVC = favourite else {
            return
        }
        //uses HomeViewController only for movie listing & favourite movie screens
        viewControllers = [UINavigationController.init(rootViewController: homeVC),UINavigationController.init(rootViewController: favouriteVC)]
        selectedIndex = 0
    }

}
