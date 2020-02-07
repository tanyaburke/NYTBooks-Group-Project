//
//  FavoritesViewController.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // remember to push ONLY through terminal and also
    
    private let fc = FavoritesView()
    
    // instance of the controller
    override func loadView() {
        view = fc
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
    }
    


}
