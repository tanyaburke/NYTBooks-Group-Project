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
    
    private let favoriteViewInstance = FavoritesView()
    
    private var favsDataPersistenceInstance: DataPersistence<BookData>
    
    init(dataPersistence: DataPersistence<BookData> ){
        favsDataPersistenceInstance = dataPersistence
        super.init(nibName: nil, bundle: nil)
        favsDataPersistenceInstance.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let favsCell = FavoriteViewCell()
    
    public var savedFavs = [BookData]() {
        didSet{
            favoriteViewInstance.favsCollectionView.reloadData()
            
            if savedFavs.isEmpty {
                favoriteViewInstance.favsCollectionView.backgroundView = EmptyStateView(title: "Theres nothing here", message: "You currently dont have anything as a saved things please go an like something.")
            } else {
                favoriteViewInstance.favsCollectionView.backgroundView = nil 
            }
        }
    }
    
    override func loadView() {
        view = favoriteViewInstance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteViewInstance.favsCollectionView.delegate = self
        favoriteViewInstance.favsCollectionView.dataSource = self
        
        favoriteViewInstance.favsCollectionView.register(FavoriteViewCell.self, forCellWithReuseIdentifier: "favCell")
        fetchSavedBooks()
        
        navigationItem.title = "Favorite Books"
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedFavs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as? FavoriteViewCell else{
            fatalError(" couldnt dequeue.")
        }
        let selectedFav = savedFavs[indexPath.row]
        
        cell.configureFavouriteViewCell(selectedFav)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        
        let itemWidth: CGFloat = maxSize.width 
        let itemheight: CGFloat = maxSize.height * 0.5
        
        return CGSize(width: itemWidth, height: itemheight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFav = savedFavs[indexPath.row]
        
        let instanceOfDetailController = BookDetailViewController(favsDataPersistenceInstance, book: selectedFav)
        instanceOfDetailController.chosenBook = selectedFav
        
        navigationController?.pushViewController(instanceOfDetailController, animated: true)
        
    }
    
    
}

extension FavoritesViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchSavedBooks()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchSavedBooks()
    }
}

extension FavoritesViewController: FavouriteViewCellDelegate {
    
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
