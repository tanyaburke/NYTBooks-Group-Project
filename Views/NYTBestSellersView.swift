//
//  NYTBestSellersView.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import ImageKit

class NYTBestSellersView: UIView {
    
    public var collectionViewHeightLayoutConstraint: NSLayoutConstraint = NSLayoutConstraint()
    public var pickerViewTopAnchorConstraint: NSLayoutConstraint = NSLayoutConstraint()
    public var desireToHide: Bool = false
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemHeight: CGFloat = maxSize.height * 0.4
        let itemWidth: CGFloat = maxSize.height * 0.3
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGray4
        return cv
    }()
    
    public lazy var hideButton: UIButton = {
       let button = UIButton()
        button.setTitle("Hide", for: .normal)
        return button
    }()
    
    public lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        let pv = UIPickerView(frame: CGRect.zero)
        pv.backgroundColor = .systemPurple
        
        return pv
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
           setupCollectionViewConstraints()
            setUpHideButtonConstraints()
           setupPickerViewConstraints()
    }
    

    private func setupCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        collectionViewHeightLayoutConstraint = collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        collectionViewHeightLayoutConstraint.isActive = true
    }
    
    private func setUpHideButtonConstraints(){
        addSubview(hideButton)
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([hideButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 2), hideButton.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    private func setupPickerViewConstraints() {
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20)
        ])
        
        pickerViewTopAnchorConstraint = pickerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40)
        pickerViewTopAnchorConstraint.isActive = true
    }
    
    
}
