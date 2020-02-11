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
    
    // FIXME: uncomment when will use data persistance from TabBarController
    //public var dataPersistence: DataPersistence<BookData>!
    
    //FIXME: if we will use userPreference for user defaults
    //public var userPreference: UserPreference!
    
    // is this correct?
    private var categories = [ListItem]()
    //{
    //        didSet {
    //            DispatchQueue.main.async {
    //                self.nytBestSellerView.pickerView.reloadAllComponents()
    //            }
    //        }
    //    }
    
    // getting data for our collection view from API:
    private var bookData = [BookData] () {
        didSet {
            DispatchQueue.main.async {
                self.nytBestSellerView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = nytBestSellerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "NYT Bestsellers"
        
        nytBestSellerView.collectionView.dataSource = self
        nytBestSellerView.collectionView.delegate = self
        
        nytBestSellerView.pickerView.dataSource = self
        nytBestSellerView.pickerView.delegate = self
        
        nytBestSellerView.collectionView.register(BookCell.self, forCellWithReuseIdentifier: "bookCell")
        
        //FIXME: if we useing user Preference for user defaults
        //let userCategoryName = userPreference.getCategoryName() ?? "Hardcover Nonfiction"
        let userCategoryName = "Hardcover Nonfiction"
        
        fetchBooks(userCategoryName)
        //fetchBooks("Hardcover Nonfiction")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //fetchBooks()
    }
    
    private func fetchBooks(_ category: String) {
        NYTAPIClient.getBookData(category) {[weak self] (result) in
            switch result {
            case .failure(let appError):
                print("fetching books error: \(appError)")
            case .success(let books):
                DispatchQueue.main.async {
                    self?.bookData = books
                }
            }
        }
    }
}

extension NYTBestsellersController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as? BookCell else {
            fatalError("coudl not downcast to BookCell")
        }
        let book = bookData[indexPath.row]
        cell.configureBookCell(book)
        cell.backgroundColor = .systemBackground
        return cell
    }
}

extension NYTBestsellersController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemHeight: CGFloat = maxSize.height * 0.20
        let itemWidth: CGFloat = maxSize.width
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = bookData[indexPath.row]
        let bookDetailVC = BookDetailViewController()
        //FIXME: What name of bookData in the BookDetailViewController?
        //bookDetailVC.book = book
        //FIXME: uncomment when connest to TabBArController and instance of DataPersistence
        //bookDetailVC.dataPersistence = dataPersitence
        navigationController?.pushViewController(bookDetailVC, animated: true)
    }
}

extension NYTBestsellersController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
}

extension NYTBestsellersController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // FIXME:
        return ""//categories[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let categoryName = categories[row]
        //userPreference.setSectionName(categoryName)
    }
}

//FIXME: when we add user defaults:
//extension NYTBestsellersController: UserPreferenceDelegate {
//    func didChangeNewsSection(_ userPreference: UserPreference, sectionName: String) {
//      fetchBooks(userCategoryName)
//    }
//}


