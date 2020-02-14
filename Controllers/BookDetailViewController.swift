//
//  BookDetailViewController.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//


import UIKit
import DataPersistence

class BookDetailViewController: UIViewController {
    
    let detailView = BookDetailView()
    var chosenBook: BookData
   
    private var dataPersistence: DataPersistence<BookData>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        // Do any additional setup after loading the view.
        navigationItem.title = chosenBook.title
        updateUI()
        
     navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favButtonPressed(_:)))
      
        
        detailView.segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    
    init(_ dataPersistence: DataPersistence<BookData>, book:BookData){
           self.dataPersistence = dataPersistence
           self.chosenBook = book
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
    
    override func viewWillLayoutSubviews() {
        detailView.textView.layer.cornerRadius = 10
        detailView.imageView.layer.cornerRadius = 10
    }
    override func loadView() {
        view = detailView
    }
    
    @objc func favButtonPressed(_ sender: UIBarButtonItem){

            do {

                try dataPersistence.createItem(chosenBook)
                DispatchQueue.main.async {
                    self.showAlert(title: "Saved", message: "Book has been added to favorites")
                }

            } catch {
                print("error saving article: \(chosenBook)")
            }
    }
    
    
    func updateUI() {
        detailView.imageView.getImage(with: chosenBook.bookImage ) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.detailView.imageView.image = UIImage(named: "exclamation.mark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailView.imageView.image = image
                    
                }
            }
        }
        
        detailView.textView.text = chosenBook.description
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl){

        let bookLink = chosenBook.buyLinks 
        
            switch sender.selectedSegmentIndex{
            case 0:
                print("selected\(sender.tag)")
                if let url = URL(string: bookLink[0].url) {
                        UIApplication.shared.open(url)
                    }
                case 1:
                    print("selected\(sender.tag)")
                    if let url = URL(string: bookLink[1].url) {
                        UIApplication.shared.open(url)
                    }
                case 2:
                    print("selected\(sender.tag)")
                if let url = URL(string: bookLink[2].url) {
                    UIApplication.shared.open(url)
                }
                case 3:
                    print("selected\(sender.tag)")
                if let url = URL(string: bookLink[3].url) {
                    UIApplication.shared.open(url)
                }
                default:
                    break
                }
        }
    
   
    
}
