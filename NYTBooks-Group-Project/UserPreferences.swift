//
//  UserPreferences.swift
//  NYTBooks-Group-Project
//

//  Created by Tanya Burke on 2/14/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation

struct Key {
    static let displayNameKey = "DisplayName"
    static let encodedName = "dataKey"
    static let selectedRow = "selectedRow"
    
}
protocol UserPreferenceDelegate: AnyObject{
    func reloadThedata(_ instanceOfUserPreferences: UserPreferences)
}

class UserPreferences {
    
    weak var delegate: UserPreferenceDelegate?

    func saveTheCategory(_ placement: ListItem, itemAt: Int){
        
        UserDefaults.standard.set(placement.displayName, forKey: Key.displayNameKey)
    
        UserDefaults.standard.set(placement.listNameEncoded, forKey: Key.encodedName)
        
        UserDefaults.standard.set(itemAt, forKey: Key.selectedRow)
        
        delegate?.reloadThedata(self)
    }
    
    func getSavedCategory() -> ListItem {
        
        guard let thecategory = UserDefaults.standard.object(forKey: Key.displayNameKey) as? String, let theEncodedName = UserDefaults.standard.object(forKey: Key.encodedName) as? String else {
            print("cant accessed the saved value...")
            
            return ListItem(displayName: "", listNameEncoded: "")
        }
        return ListItem(displayName: thecategory, listNameEncoded: theEncodedName)
    }
    
    func getTheRow() -> Int {
        guard let theSelectedRow = UserDefaults.standard.object(forKey: Key.selectedRow) as? Int else {
            print("it did not work")
            return 0 
        }
        
        return theSelectedRow
    }
}
