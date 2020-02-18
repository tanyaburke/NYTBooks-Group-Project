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
        
        view.backgroundColor = .systemBackground
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
      
            
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneDelegate = (scene?.delegate as? SceneDelegate) {
                UIView.transition(with: self.logoAnimationView,
                                  duration: 1.0,
                                           options: .transitionCrossDissolve,
                                           animations: nil,
                                           completion: nil)
                sceneDelegate.afterSplashScreenAnimation()
            }
        }
     
    }

    
    override func loadView() {
        view = logoAnimationView
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}
