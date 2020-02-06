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
    
    override func loadView() {
        view = nytBestSellerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        navigationItem.title = "NYT Bestsellers"
        
        //nytBestSellerView.collectionView.dataSource = self
        //nytBestSellerView.collectionView.delegate = self
        
        //FIXME: when I will have cell name
//        nytBestSellerView.collectionView.register(UINib(nibName: "BookCell", bundle: nil),  forCellWithReuseIdentifier: "bookCell")
    
    }

}

//extension NYTBestsellersController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        //FIXME: I should change it with books.count
//        return 52
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as? BookCell else {
//            fatalError("could not downcast to BookCell")
//        }
//        cell.backgroundColor = .green
//        return cell
//    }
//}

extension NYTBestsellersController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.5
        return CGSize(width: itemWidth, height: 120)
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //FIXME:
//        // let podcast = podcasts[indexPath.row]
//        //guard let bookDetailVC =
//        navigationController?.pushViewController(bookDetailVC, animated: true)
//    }
}
