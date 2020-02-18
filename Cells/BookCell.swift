//
//  CollectionViewCell.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import ImageKit

class BookCell: UICollectionViewCell {
    
    private var pictureIsShowing = true
    
    lazy var bookCoverImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.image = UIImage(systemName: "book")
        imageView.alpha = 1.0
        return imageView
    }()
    
    lazy var numberOfWeeksBestSellerLabel: UILabel = {
      let label = UILabel()
        label.textAlignment = .left
        label.text = "Some filler text"
        label.backgroundColor = .systemGray4
        label.alpha = 0.0
        return label
    }()
    
    lazy var bookBlurbTextView: UITextView = {
       let textView = UITextView()
        textView.text = "A description about the book shown above"
        textView.backgroundColor = .systemGray4
        textView.isEditable = false
        textView.alpha = 0.0
        return textView
    }()
    
    lazy var longPress: UILongPressGestureRecognizer = {
       let lp = UILongPressGestureRecognizer()
        lp.addTarget(self, action: #selector(longPressHappened))
        return lp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpFavouriteViewCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpFavouriteViewCell()
    }
    
    private func setUpFavouriteViewCell(){
        setUpBookCoverImageViewConstraints()
        setUpNumberOfWeeksBestSellerLabelConstraints()
        setUpBookBlurbTextFieldConstraints()
        addGestureRecognizer(longPress)
        bookBlurbTextView.isUserInteractionEnabled = false
        bookBlurbTextView.isEditable = false
    }
    
    private func setUpBookCoverImageViewConstraints(){
        addSubview(bookCoverImageView)
    
        bookCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([bookCoverImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor), bookCoverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1.0), bookCoverImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0)])
    }
    
    private func setUpNumberOfWeeksBestSellerLabelConstraints() {
        addSubview(numberOfWeeksBestSellerLabel)
        numberOfWeeksBestSellerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([numberOfWeeksBestSellerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), numberOfWeeksBestSellerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), numberOfWeeksBestSellerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), numberOfWeeksBestSellerLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setUpBookBlurbTextFieldConstraints(){
        addSubview(bookBlurbTextView)
        bookBlurbTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bookBlurbTextView.topAnchor.constraint(equalTo: numberOfWeeksBestSellerLabel.bottomAnchor, constant: 8), bookBlurbTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), bookBlurbTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), bookBlurbTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)])
    }
    
    @objc
    public func longPressHappened(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began || gesture.state == .changed {
            return
        }
        flipItOver()
    }
    
    public func flipItOver(){
        if pictureIsShowing{
            UIView.transition(with: self, duration: 1.0, options: [.transitionFlipFromTop], animations: {
                self.bookCoverImageView.alpha = 0.0
                self.numberOfWeeksBestSellerLabel.alpha = 1.0
                self.bookBlurbTextView.alpha = 1.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: 1.0, options: [.transitionFlipFromBottom], animations: {
                self.bookCoverImageView.alpha = 1.0
                self.numberOfWeeksBestSellerLabel.alpha = 0.0
                self.bookBlurbTextView.alpha = 0.0
            }, completion: nil)
        }
        pictureIsShowing.toggle()
    }
    
    public func configureBookCell(_ modelData: BookData){
        numberOfWeeksBestSellerLabel.text = "\(modelData.weeksOnList) week(s) on the best sellers list"
        bookBlurbTextView.text = modelData.description
        bookCoverImageView.getImage(with: modelData.bookImage) { [weak self] result in
            switch result{
            case .failure(let appError):
                print("Error loading image: \(appError)")
            case .success(let image):
                DispatchQueue.main.async{
                    self?.bookCoverImageView.image = image
                }
            }
        }
    }
}
