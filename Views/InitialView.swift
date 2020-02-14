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
            logoGifImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            logoGifImageView.bottomAnchor.constraint(equalTo:safeAreaLayoutGuide.bottomAnchor).isActive = true
            logoGifImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
            logoGifImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
    }

    
extension InitialView{
        
        func pinEdgesToSuperView() {
            guard let superView = superview else { return }
            translatesAutoresizingMaskIntoConstraints = false
            topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
            leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
            rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        }
        
    }

