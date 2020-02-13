//
//  BookDetailViewController.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//


import UIKit

class BookDetailViewController: UIViewController {
    
    let detailView = BookDetailView()
    var chosenBook: BookData?
   
//    public var dataPersistence: DataPersistence<Article>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        // Do any additional setup after loading the view.
        navigationItem.title = chosenBook?.title
        updateUI()
        
     navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favButtonPressed(_:)))
      
        
        detailView.segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    override func viewWillLayoutSubviews() {
        detailView.textView.layer.cornerRadius = 10
        detailView.imageView.layer.cornerRadius = 10
    }
    override func loadView() {
        view = detailView
    }
    
    @objc func favButtonPressed(_ sender: UIBarButtonItem){
//        guard let book = chosenBook else { return }
//        let favVC = FavoritesViewController()
//            do {
//
////                try dataPersistence.createItem(book)
//
//            } catch {
//                print("error saving article: \(book)")
//            }
    }
    
    
    func updateUI() {
        detailView.imageView.getImage(with: chosenBook?.bookImage ?? "") { [weak self] (result) in
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
        
        detailView.textView.text = chosenBook?.description
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl){

        guard let bookLink = chosenBook?.buyLinks else{ return}
        
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
