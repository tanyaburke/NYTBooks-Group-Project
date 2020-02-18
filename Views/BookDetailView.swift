//
//  BookDetailView.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class BookDetailView: UIView {

   //UIButton or Segmented control There should be 4 buttons or 4 segemented control that would take you to a safari view controller to present the book sellers webpage
    //
    //Safari ViewController It should show Amazon, apple books, Barnes & Nobles, Local Book Sellers based on one of the 4 buttons selected
    //
    //The Detail ViewController should show the Book's image (Large image), a TextView for the description and a label for the book title and a Favorite button.
    //
    //Favorites Button When a user favorites a book there should be a show alert or animation (It's up to you) anything that shows the user the book they favrited was added.

    
    
    
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
                 segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//                 segmentedControl.bottomAnchor.constraint(equalTo: centerYAnchor)
//        segments.center = UIScreen.main.bounds.anchorY
     ])
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
