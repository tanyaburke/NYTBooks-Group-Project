//
//  NYTBestsellersController.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class NYTBestsellersController: UIViewController {
    
    private let nytBestSellerView = NYTBestSellersView()
    
    private let categories = ["Business", "Technology", "Travel", "Authobiography", "Novels"]
    
    override func loadView() {
        view = nytBestSellerView
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        navigationItem.title = "NYT Bestsellers"
        
        nytBestSellerView.collectionView.dataSource = self
        //nytBestSellerView.collectionView.delegate = self
        
        nytBestSellerView.pickerView.dataSource = self
        nytBestSellerView.pickerView.delegate = self
        
        //FIXME: when I will have cell name
//        nytBestSellerView.collectionView.register(UINib(nibName: "BookCell", bundle: nil),  forCellWithReuseIdentifier: "bookCell")
        
        // register a collectionView cell
        //         we use generic cell
    nytBestSellerView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "bookCell")
    
    }

}

extension NYTBestsellersController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //FIXME: I should change it with books.count
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
}

extension NYTBestsellersController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemHeight: CGFloat = maxSize.height
        let itemWidth: CGFloat = maxSize.height * 0.5
        return CGSize(width: itemWidth, height: itemHeight)
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //FIXME:
//        // let podcast = podcasts[indexPath.row]
//        //guard let bookDetailVC =
//        navigationController?.pushViewController(bookDetailVC, animated: true)
//    }
}

    extension NYTBestsellersController: UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            
            // FIXME: I will need to add books.count
            //return 52
            return categories.count
        }
    }

extension NYTBestsellersController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // FIXME:
        return categories[row]
    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//       // _ = categories[row]
//    }
}


