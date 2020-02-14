//
//  Alert.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/13/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}
