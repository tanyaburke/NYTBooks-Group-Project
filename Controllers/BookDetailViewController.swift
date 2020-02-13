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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        // Do any additional setup after loading the view.
        navigationItem.title =  "Book Title"
    }
    
    override func loadView() {
        view = detailView
    }
    

    //UIButton or Segmented control There should be 4 buttons or 4 segemented control that would take you to a safari view controller to present the book sellers webpage
    //
    //Safari ViewController It should show Amazon, apple books, Barnes & Nobles, Local Book Sellers based on one of the 4 buttons selected
    //
    //The Detail ViewController should show the Book's image (Large image), a TextView for the description and a label for the book title and a Favorite button.
    //
    //Favorites Button When a user favorites a book there should be a show alert or animation (It's up to you) anything that shows the user the book they favrited was added.

}
