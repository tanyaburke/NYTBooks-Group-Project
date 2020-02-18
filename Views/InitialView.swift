//
//  InitialView.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/13/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class InitialView: UIView {

    public lazy var logoGifImageView: UIImageView = {
     let gifImage =  UIImageView()
        gifImage.loadGif(name: "bookStack")
        gifImage.backgroundColor = .yellow
        gifImage.contentMode = .scaleToFill
        gifImage.animationDuration = 2.0
            return gifImage
        }()
    
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
            
        }

    
    

        
        private func commonInit() {
//            backgroundColor = UIColor(white: 246.0 / 255.0, alpha: 1)
            addSubview(logoGifImageView)
            logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
            logoGifImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            logoGifImageView.bottomAnchor.constraint(equalTo:safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
            logoGifImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -100).isActive = true
            logoGifImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 100).isActive = true
        }
    }

//
//private func animate() {
//let duration: Double = 1.0
//    UIView.transition(with: , duration: <#T##TimeInterval#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//    UIView.transition(with: self, duration: duration, options: [], animations: {
//    gifImage.alpha = 1.0
//  }, completion: nil)

//}
