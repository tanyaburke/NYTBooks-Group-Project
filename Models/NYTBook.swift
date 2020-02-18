//
//  NYTBook.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation

struct ListWrapper: Codable{
    let results: [ListItem]
}

struct ListItem: Codable, Equatable{
    let displayName: String
    let listNameEncoded: String
    
    private enum CodingKeys: String, CodingKey{
        case displayName = "display_name"
        case listNameEncoded = "list_name_encoded"
    }
}

struct TopLevelBookResult: Codable{
    let results: BookWrapper
}
struct BookWrapper: Codable {
    let books: [BookData]
}

struct BookData: Codable, Equatable{
    let rank: Int
    let weeksOnList: Int
    let publisher: String
    let description: String
    let title: String
    let author: String
    let bookImage: String
    let bookImageWidth: Int
    let bookImageHeight: Int
    let buyLinks: [ProductLink]
    
    private enum CodingKeys: String, CodingKey{
        case rank
        case weeksOnList = "weeks_on_list"
        case publisher
        case description
        case title
        case author
        case bookImage = "book_image"
        case bookImageWidth = "book_image_width"
        case bookImageHeight = "book_image_height"
        case buyLinks = "buy_links"
    }
}

struct ProductLink: Codable, Equatable{
    let name: String
    let url: String
}

