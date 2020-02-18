//
//  NYTBestsellersController.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import DataPersistence
import ImageKit

class NYTBestsellersController: UIViewController {
    
    private let nytBestSellerView = NYTBestSellersView()
    
    var dataPersistence: DataPersistence<BookData>
    
    var instanceOfUserPreferences: UserPreferences
    
    init(dataPersistence: DataPersistence<BookData>, userPreferences: UserPreferences){
        self.instanceOfUserPreferences = userPreferences
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
        instanceOfUserPreferences.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var categoriesOfBooks = [ListItem]() {
        didSet {
            DispatchQueue.main.async {
                self.nytBestSellerView.pickerView.reloadAllComponents()
                let selected = self.instanceOfUserPreferences.getTheRow()
                self.nytBestSellerView.pickerView.selectRow(selected, inComponent: 0, animated: true)
            }
        }
    }

    private var bookData = [BookData] () {
        didSet{
               DispatchQueue.main.async{
                   self.nytBestSellerView.collectionView.reloadData()
               }
               if !bookData.isEmpty{
                   DispatchQueue.main.async{
                       self.nytBestSellerView.collectionView.backgroundView = nil
                   }
               } else {
                   DispatchQueue.main.async{
                       self.nytBestSellerView.collectionView.backgroundView = EmptyStateView(title: "No Default Category Selected", message: "Navigate to the settings menu to select a default category, or use the picker view below to display best sellers from a category.")
                   }
               }
           }
    }
    
    override func loadView() {
        view = nytBestSellerView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        navigationItem.title = "NYT Bestsellers"
        
        nytBestSellerView.collectionView.dataSource = self
        nytBestSellerView.collectionView.delegate = self
        
        nytBestSellerView.pickerView.dataSource = self
        nytBestSellerView.pickerView.delegate = self
        
        nytBestSellerView.collectionView.register(BookCell.self, forCellWithReuseIdentifier: "bookCell")
        
        getCategories()
        fetchBooks(userCategory: instanceOfUserPreferences.getSavedCategory().listNameEncoded)
        
       nytBestSellerView.hideButton.addTarget(self, action: #selector(hidePickerView(_:)), for: .touchUpInside)
    }
    
    private func getCategories() {
        NYTAPIClient.getCategories {[weak self] (result) in
            switch result {
            case .failure(let appError):
                print("getting categories error:  \(appError)")
            case .success(let categoryName):
                self?.categoriesOfBooks = categoryName
            }
        }
    }
    
    
    private func fetchBooks(userCategory: String) {
        if userCategory == "" {
            self.nytBestSellerView.collectionView.backgroundView = EmptyStateView(title: "No Default Category Selected", message: "Navigate to the settings menu to select a default category, or use the picker view below to display best sellers from a category.")
        } else {
            NYTAPIClient.getBookData(userCategory) { [weak self] result in
                switch result{
                case .failure(let appError):
                    print("Error getting bookData: \(appError)")
                case .success(let data):
                    self?.bookData = data
                }
            }
        }
    }
    
        @objc
        private func hidePickerView(_ sender: UIButton){
            
            if !nytBestSellerView.desireToHide {
                nytBestSellerView.hideButton.setTitle("Show", for: .normal)
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveLinear], animations: {
                self.nytBestSellerView.collectionViewHeightLayoutConstraint.isActive = false
                self.nytBestSellerView.collectionViewHeightLayoutConstraint = self.nytBestSellerView.collectionView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.95)
                self.nytBestSellerView.collectionViewHeightLayoutConstraint.isActive = true
                self.nytBestSellerView.pickerView.alpha = 0.0
            }, completion: { done in
                if done{
                    self.view.layoutIfNeeded()
                }
            })
            } else{
                nytBestSellerView.hideButton.setTitle("Hide", for: .normal)
                UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveLinear], animations: {
                    self.nytBestSellerView.collectionViewHeightLayoutConstraint.isActive = false
                    self.nytBestSellerView.collectionViewHeightLayoutConstraint = self.nytBestSellerView.collectionView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.65)
                    self.nytBestSellerView.collectionViewHeightLayoutConstraint.isActive = true
                    self.nytBestSellerView.pickerView.alpha = 1.0
                }, completion: { done in
                    if done{
                        self.view.layoutIfNeeded()
                    }
                })
            }
            nytBestSellerView.desireToHide.toggle()
        }
}

extension NYTBestsellersController: UserPreferenceDelegate {
    func reloadThedata(_ instanceOfUserPreferences: UserPreferences) {
        fetchBooks(userCategory: instanceOfUserPreferences.getSavedCategory().listNameEncoded)
        DispatchQueue.main.async {
            self.nytBestSellerView.pickerView.reloadAllComponents()
            let selected = self.instanceOfUserPreferences.getTheRow()
            self.nytBestSellerView.pickerView.selectRow(selected, inComponent: 0, animated: true)
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
        cell.backgroundColor = .systemGray4
        return cell
    }
}

extension NYTBestsellersController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.6
        return CGSize(width: itemWidth, height: collectionView.bounds.size.height * 0.9)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = bookData[indexPath.row]
        let bookDetailVC = BookDetailViewController(dataPersistence, book: book)
        navigationController?.pushViewController(bookDetailVC, animated: true)
    }
}

extension NYTBestsellersController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesOfBooks.count
    }
}

extension NYTBestsellersController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriesOfBooks[row].displayName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let userCategory = categoriesOfBooks[row].listNameEncoded
        fetchBooks(userCategory: userCategory)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: categoriesOfBooks[row].displayName, attributes: [NSAttributedString.Key.foregroundColor:UIColor.systemGray4])
    }
}


