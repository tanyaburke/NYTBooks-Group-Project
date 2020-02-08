//
//  NYAPIClient.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation
import NetworkHelper

struct NYTAPIClient{
    static func getCategories(completion: @escaping (Result<[ListItem],AppError>) -> ()){
        let endpointURL = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(APIKeys.NYTimesBestSellersKey)"
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { result in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let listWrapper = try JSONDecoder().decode(ListWrapper.self, from: data)
                    completion(.success(listWrapper.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func getBookData(_ userCategory: String, completion: @escaping (Result<[BookData],AppError>) -> ()){
        let urlEndpoint = "https://api.nytimes.com/svc/books/v3/lists/current/\(userCategory).json?api-key=\(APIKeys.NYTimesBestSellersKey)"
        
        guard let url = URL(string: urlEndpoint) else {
            completion(.failure(.badURL(urlEndpoint)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { result in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let bookWrapper = try JSONDecoder().decode(TopLevelBookResult.self, from: data)
                    completion(.success(bookWrapper.results.books))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
