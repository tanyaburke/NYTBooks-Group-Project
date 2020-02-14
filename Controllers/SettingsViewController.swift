//
//  SettingsViewController.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let settingsView = SettingsView()
    
    var instanceOfUserPreferencesFromSettingsController: UserPreferences
    
    init( userPerferences: UserPreferences){
        self.instanceOfUserPreferencesFromSettingsController = userPerferences
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // testing data for the view
    private var categories: [ListItem] = [] {
        didSet{
            DispatchQueue.main.async {
                self.settingsView.settingsPickerView.reloadAllComponents()
            }
        }
    }
        
        //= ["Business", "Technology", "Travel", "Authobiography", "Novels"]
    
    override func loadView() {
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        navigationItem.title = "Pick Default Category"
        
        settingsView.settingsPickerView.dataSource = self
        settingsView.settingsPickerView.delegate = self
        loadTheCategories()
    }
    
    private func loadTheCategories() {
        NYTAPIClient.getCategories(completion: { [weak self]
            (result) in
            switch result {
            case .failure(let appError):
                print("the apperror is \(appError)")
            case .success(let categories):
                self?.categories = categories
                
            }
        })
        
        
    }
}

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // FIXME: I will need to add books.count
        //return 52
        //FIXME:
        return categories.count
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // FIXME:
        
        return categories[row].displayName
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        instanceOfUserPreferencesFromSettingsController.saveTheCategory(categories[row])
        
        
    }
}
