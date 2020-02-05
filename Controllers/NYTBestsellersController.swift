//
//  NYTBestsellersController.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class NYTBestsellersController: UIViewController {
    
    private let nytBestSellerView = NYTBestSellersView()
    
    override func loadView() {
        view = nytBestSellerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
    }

}
