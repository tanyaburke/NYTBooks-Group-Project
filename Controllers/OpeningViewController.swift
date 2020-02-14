//
//  OpeningViewController.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/13/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class OpeningViewController: UIViewController {

  
     let logoAnimationView = InitialView()
            
            override func viewDidLoad() {
                super.viewDidLoad()
                view.addSubview(logoAnimationView)
                logoAnimationView.pinEdgesToSuperView()
//                logoAnimationView.logoGifImageView.delegate = self
            }
            
            override func viewDidAppear(_ animated: Bool) {
                super.viewDidAppear(animated)
//                logoAnimationView.logoGifImageView.startAnimatingGif()
            }

        


}
