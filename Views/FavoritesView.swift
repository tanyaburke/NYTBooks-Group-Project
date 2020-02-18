//
//  FavoritesView.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//
import UIKit

class FavoritesView: UIView {
 
    public lazy var favsCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           
           let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
           collection.backgroundColor = .systemPurple
           return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        favCollectionsSetUp()
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        favCollectionsSetUp()
        
    }
    
    func favCollectionsSetUp(){
        addSubview(favsCollectionView)
        
        favsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favsCollectionView.topAnchor.constraint(equalTo: topAnchor),
            favsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
        
    }
    
    
    
    
}
