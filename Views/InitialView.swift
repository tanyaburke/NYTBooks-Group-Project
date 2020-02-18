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
    
    public lazy var groupName: UIImageView = {
        let groupName = UIImageView()
        groupName.loadGif(name:"groupName")
        groupName.contentMode = .scaleToFill
        return groupName
    }()
    
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
            
        }

    private func commonInit(){
        loadingGif()
        groupNameConstraints()
    }
    

        
        private func loadingGif() {
//            backgroundColor = UIColor(white: 246.0 / 255.0, alpha: 1)
            addSubview(logoGifImageView)
            logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
            logoGifImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            logoGifImageView.bottomAnchor.constraint(equalTo:safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
            logoGifImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -100).isActive = true
            logoGifImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 100).isActive = true
        }
    
    private func groupNameConstraints(){
addSubview(groupName)
        groupName.translatesAutoresizingMaskIntoConstraints = false
        groupName.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        groupName.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        groupName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        groupName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    
    }

}

