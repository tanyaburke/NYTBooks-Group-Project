//
//  NYTBooks_Group_ProjectTests.swift
//  NYTBooks-Group-ProjectTests
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import XCTest
@testable import NYTBooks_Group_Project

class NYTBooks_Group_ProjectTests: XCTestCase {
    
    func testCategoryModel(){
        // Arrange
        var categories = [ListItem]()
        let exp = expectation(description: "Receive 59 Categories")
        let expectedNumberOfItems = 59
        
        // Act
        NYTAPIClient.getCategories { result in
            switch result{
            case .failure(let appError):
                XCTFail("Failed to retrieve categories: \(appError)")
            case .success(let listItems):
                exp.fulfill()
                categories = listItems
                // Assert
                XCTAssertEqual(expectedNumberOfItems, listItems.count)
            }
        }
        wait(for: [exp], timeout: 3.0)
    }
    
    func testBookDataModel(){
        // Arrange
        var bookList = [BookData]()
        let exp = expectation(description: "Get back some book data")
        let firstExpectedTitle = "AMERICAN DIRT"
        
        // Act
        // This is a bit peculiar in that the category cannot contain a space.
        NYTAPIClient.getBookData("hardcover-fiction") { result in
            switch result{
            case .failure(let appError):
                XCTFail("Could not retrieve book data: \(appError)")
            case .success(let books):
                exp.fulfill()
                bookList = books
                // Assert
                XCTAssertEqual(firstExpectedTitle, bookList.first!.title)
            }
        }
        wait(for: [exp], timeout: 3.0)
    }

}
