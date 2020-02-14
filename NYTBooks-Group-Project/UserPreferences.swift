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
    
}
protocol UserPreferenceDelegate: AnyObject{
    // where you observe the change you should call it..
    func reloadThedata(_ instanceOfUserPreferences: UserPreferences)
   
}

class UserPreferences {
    // this needs to be a class because with a struct it will make a completely different class of the same thing.. and even though it may be the exact same thing it is not the thing that we are referencing so when we call it.. we are technically not caling the same thing
    
    weak var delegate: UserPreferenceDelegate?
    // need to save
    func saveTheCategory(_ placement: ListItem){
        
        // this line saves it
        UserDefaults.standard.set(placement.displayName, forKey: Key.displayNameKey)
    
        UserDefaults.standard.set(placement.listNameEncoded, forKey: Key.encodedName)
        
        // im in here something is changing and it is happening when this happens so please listen and pay attention
        delegate?.reloadThedata(self)
    }
    
    // get to get the saved things
    func getSavedCategory() -> ListItem {
        
        guard let thecategory = UserDefaults.standard.object(forKey: Key.displayNameKey) as? String, let theEncodedName = UserDefaults.standard.object(forKey: Key.encodedName) as? String else {
            print("cant accessed the saved value...")
            
            return ListItem(displayName: "", listNameEncoded: "")
        }
        return ListItem(displayName: thecategory, listNameEncoded: theEncodedName)
    }
}
