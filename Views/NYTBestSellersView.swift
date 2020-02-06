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

    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 200)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemYellow
        return cv
    }()
    
    public lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        let pv = UIPickerView(frame: CGRect.zero)
        pv.backgroundColor = .systemBlue
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
           setupPickerViewConstraints()
       }

    private func setupCollectionViewConstraints() {
          addSubview(collectionView)
          collectionView.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
              collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
              collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
          ])
      }
    
    private func setupPickerViewConstraints() {
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20)
        ])
    }
    
    
}
