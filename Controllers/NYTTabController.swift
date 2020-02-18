//
//  NYTTabController.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

import DataPersistence

class NYTTabController: UITabBarController {

    private var tabBarInstanceOfDataPersistence = DataPersistence<BookData>(filename: "favBooks.plist")
    private var tabBarInstanceOfUserPreference = UserPreferences()
    
     private lazy var nytBestsellersVC: NYTBestsellersController = {
        let vc = NYTBestsellersController(dataPersistence: tabBarInstanceOfDataPersistence, userPreferences: tabBarInstanceOfUserPreference)
        
        vc.instanceOfUserPreferences = tabBarInstanceOfUserPreference
            //need to add the instance of dataPeristence inside of the bestSeller controller...
            vc.tabBarItem = UITabBarItem(title: "BestSellers", image: UIImage(systemName: "book"), tag: 0)
            return vc
        }()
        
        private lazy var favVC: FavoritesViewController = {
            let vc = FavoritesViewController(dataPersistence: tabBarInstanceOfDataPersistence)
            vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 1)
            return vc
        }()
    
        
        private lazy var settingsVC: SettingsViewController = {
            let vc = SettingsViewController(userPerferences: tabBarInstanceOfUserPreference)
            
            vc.instanceOfUserPreferencesFromSettingsController = tabBarInstanceOfUserPreference
            // need the user preference set up for the picker
            vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
            
            return vc
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            viewControllers  = [  UINavigationController(rootViewController: nytBestsellersVC), UINavigationController(rootViewController: favVC), UINavigationController(rootViewController: settingsVC)]
          
            

          
        }
        


    }


