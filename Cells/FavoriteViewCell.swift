//
//  FavoriteViewCell.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import ImageKit

protocol FavouriteViewCellDelegate: AnyObject{
    func moreOptionsButtonPressed(_ favouriteViewCell: FavoriteViewCell, book: BookData)
}

class FavoriteViewCell: UICollectionViewCell {
    
    weak var delegate: FavouriteViewCellDelegate?

    private var modelData: BookData?
    
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
        label.backgroundColor = .systemRed
        label.alpha = 1.0
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
    
    lazy var moreOptionsButton: UIButton = {
       let button = UIButton()
        button.setTitle("", for: .normal)
        button.setBackgroundImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.addTarget(self, action: #selector(moreOptionsButtonPressed), for: .touchUpInside)
        button.alpha = 1.0
        return button
    }()
    
    lazy var longPress: UILongPressGestureRecognizer = {
        let lp = UILongPressGestureRecognizer()
        lp.addTarget(self, action: #selector(cellLongPressed(_:)))
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
        setUpMoreOptionsButtonConstraints()
        setUpNumberOfWeeksBestSellerLabelConstraints()
        setUpBookBlurbTextViewConstraints()
        addGestureRecognizer(longPress)
        bookBlurbTextView.isUserInteractionEnabled = false
        bookBlurbTextView.isEditable = false
    }
    
    private func setUpBookCoverImageViewConstraints(){
        addSubview(bookCoverImageView)
    
        bookCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([bookCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), bookCoverImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor), bookCoverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9), bookCoverImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)])
    }
    
    private func setUpMoreOptionsButtonConstraints() {
        addSubview(moreOptionsButton)
        moreOptionsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([moreOptionsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), moreOptionsButton.widthAnchor.constraint(equalToConstant: 50), moreOptionsButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func setUpNumberOfWeeksBestSellerLabelConstraints() {
        addSubview(numberOfWeeksBestSellerLabel)
        numberOfWeeksBestSellerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([numberOfWeeksBestSellerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 58), numberOfWeeksBestSellerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), numberOfWeeksBestSellerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), numberOfWeeksBestSellerLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setUpBookBlurbTextViewConstraints(){
        addSubview(bookBlurbTextView)
        bookBlurbTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bookBlurbTextView.topAnchor.constraint(equalTo: numberOfWeeksBestSellerLabel.bottomAnchor, constant: 8), bookBlurbTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), bookBlurbTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), bookBlurbTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)])
    }
    
    @objc
    public func cellLongPressed(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began || gesture.state == .changed{
            return
        }
        flipItOver()
    }
    
    private func flipItOver(){
        if pictureIsShowing{
            UIView.transition(with: self, duration: 1.0, options: [.transitionFlipFromBottom], animations: {
                self.bookCoverImageView.alpha = 0.0
                self.numberOfWeeksBestSellerLabel.alpha = 1.0
                self.bookBlurbTextView.alpha = 1.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: 1.0, options: [.transitionFlipFromTop], animations: {
                self.bookCoverImageView.alpha = 1.0
                self.numberOfWeeksBestSellerLabel.alpha = 0.0
                self.bookBlurbTextView.alpha = 0.0
            }, completion: nil)
        }
        pictureIsShowing.toggle()
    }
    
    public func configureFavouriteViewCell(_ modelData: BookData){
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
    
    @IBAction func moreOptionsButtonPressed(_ sender: UIButton){
        delegate?.moreOptionsButtonPressed(self, book: modelData!)
    }
    

}
