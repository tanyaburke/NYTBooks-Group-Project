//
//  FavoritesViewController.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // remember to push ONLY through terminal and also
    
    // instance of the controller
    private let favoriteViewInstance = FavoritesView()
    
    //making the instance of the empty array for the favs
    // need model inorder to add what is suppose to be in the array.
    public var savedFavs = [String]()
    
    override func loadView() {
        view = favoriteViewInstance
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        favoriteViewInstance.favsCollectionView.delegate = self
        favoriteViewInstance.favsCollectionView.dataSource = self
        
        // need to set the nib for the cell here.
        favoriteViewInstance.favsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "favCell")
    }
    
}

extension FavoritesViewController: UICollectionViewDataSource {
    // amount of items
    // what is the item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // savedFavs.count
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath)
       // let selectedFav = savedFavs[indexPath.row]

        cell.backgroundColor = .white
        return cell
    }
    
    // will we be doing a configure cell
    
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    // when I do something then someone else will listen...
    // delegates listen for what we want ...
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        
        let itemWidth: CGFloat = maxSize.width 
        let itemheight: CGFloat = maxSize.height * 0.30
        
        return CGSize(width: itemWidth, height: itemheight)
    }
    
    
}
