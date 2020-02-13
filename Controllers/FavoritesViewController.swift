//
//  FavoritesViewController.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesViewController: UIViewController {

    // remember to push ONLY through terminal and also
    
    // instance of the controller
    private let favoriteViewInstance = FavoritesView()
    
    public var favsDataPersistenceInstance: DataPersistence<BookData>!

    //added the instance of the cell
    private let favsCell = FavoriteViewCell()
    
    public var selectedfav: BookData?
    //making the instance of the empty array for the favs
    // need model inorder to add what is suppose to be in the array.
    public var savedFavs = [BookData]()
    {
        didSet{
            favoriteViewInstance.favsCollectionView.reloadData() // reload the data inside of the collection view
            
            if savedFavs.isEmpty {
                // need to make an extension for when the colletion view is empty
               // favoriteViewInstance.favsCollectionView.backgroundView = EmptyCollection()
                
            }
        }
    }
    
    
    override func loadView() {
        view = favoriteViewInstance
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        favoriteViewInstance.favsCollectionView.delegate = self
        favoriteViewInstance.favsCollectionView.dataSource = self
        
        // need to set the nib for the cell here.
        favoriteViewInstance.favsCollectionView.register(FavoriteViewCell.self, forCellWithReuseIdentifier: "favCell")
        fetchSavedBooks()
        
    }
    
    private func fetchSavedBooks(){
        do{
            savedFavs = try favsDataPersistenceInstance.loadItems()
        }catch {
            print("the error is because \(error)")
        }
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    // amount of items
    // what is the item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // savedFavs.count
        return savedFavs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as? FavoriteViewCell else{
            fatalError(" couldnt dequeue.")
        }
        let selectedFav = savedFavs[indexPath.row]

        cell.configureFavouriteViewCell(selectedFav)
        
        cell.delegate = self
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedrFav = savedFavs[indexPath.row]
        
        let instanceOfDetailController = BookDetailViewController()
        
      // instanceOfDetailController.chosenBook = selectedFav
        
        navigationController?.pushViewController(instanceOfDetailController, animated: true)
    }
    
    
}

extension FavoritesViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
    
    }
}

extension FavoritesViewController: FavouriteViewCellDelegate {
    

    // need to implement the button...
    func moreOptionsButtonPressed(_ favouriteViewCell: FavoriteViewCell, book: BookData) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
            alertAction in
            self.deleteSomething(book)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true)
    }
    
    
    private func deleteSomething(_ book: BookData){
        
        guard let index = savedFavs.firstIndex(of: book) else {
            return
        }
        
        do{
            try favsDataPersistenceInstance.deleteItem(at: index)
        } catch {
            print("whatever is the error is it is: \(error)")
        }
        
    }
    
    
}
