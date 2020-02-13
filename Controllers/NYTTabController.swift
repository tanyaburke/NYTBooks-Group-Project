//
//  NYTTabController.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class NYTTabController: UITabBarController {

     private lazy var nytBestsellersVC: NYTBestsellersController = {
            let vc = NYTBestsellersController()
            vc.tabBarItem = UITabBarItem(title: "BestSellers", image: UIImage(systemName: "book"), tag: 0)
            return vc
        }()
        
        private lazy var favVC: FavoritesViewController = {
            let vc = FavoritesViewController()
            vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 1)
            return vc
        }()
        
        private lazy var settingsVC: SettingsViewController = {
            let vc = SettingsViewController()
            vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
            return vc
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            viewControllers  = [  UINavigationController(rootViewController: nytBestsellersVC), UINavigationController(rootViewController: favVC), UINavigationController(rootViewController: settingsVC)]
          
            

          
        }
        


    }


