//
//  BookDetailView.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class BookDetailView: UIView {

    public lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
            return imageView
        }()
    
    public lazy var textView: UITextView = {
        let tv = UITextView()
        tv.font = .italicSystemFont(ofSize: 20)
        tv.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        tv.text = "Sample text"
        tv.isEditable = false
        tv.backgroundColor = .systemBackground

        return tv
    }()
    
    
    public lazy var segmentedControl:UISegmentedControl  = {
       let segments = UISegmentedControl()
        segments.insertSegment(withTitle: "Amazon", at: 0, animated: true)
        segments.insertSegment(withTitle: "Barnes&Noble", at: 1, animated: true)
        segments.insertSegment(withTitle: "AppleBooks", at: 2, animated: true)
        segments.insertSegment(withTitle: "LocalStore", at: 3, animated: true)

         segments.layer.cornerRadius = 5.0
         segments.backgroundColor = .systemBackground
          segments.tintColor = .yellow
        
         return segments
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
            setUpImageViewConstraints()
           setupSegmentedControlConstraints()
           
            setupTextFeildConstraints()
         }
     
   private  func setUpImageViewConstraints() {
               
                addSubview(imageView)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                    imageView.heightAnchor.constraint(equalToConstant: 350),
                    imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
                    imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
                ])
                
            }
     
    
     private func setupSegmentedControlConstraints(){
         
         addSubview(segmentedControl)
         segmentedControl.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                 segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
                 segmentedControl.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
                 segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                 segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)])
     }
    
    private func setupTextFeildConstraints(){
        addSubview(textView)

        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        textView.centerXAnchor.constraint(equalTo: centerXAnchor),
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
}
