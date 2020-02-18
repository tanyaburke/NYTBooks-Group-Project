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
 
    public var instanceOfUserPreferencesFromSettingsController: UserPreferences
    
    init( userPerferences: UserPreferences){
        self.instanceOfUserPreferencesFromSettingsController = userPerferences
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var categories: [ListItem] = [] {
        didSet{
            DispatchQueue.main.async {
                self.settingsView.settingsPickerView.reloadAllComponents()

            }
            
            let selected = instanceOfUserPreferencesFromSettingsController.getTheRow()

            //let parts = self.categories.firstIndex(of: selected)
            
            settingsView.settingsPickerView.selectRow(selected, inComponent: 0, animated: true)
        }
    }
        
    
    override func loadView() {
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        navigationItem.title = "Pick Default Category"
        
        settingsView.settingsPickerView.dataSource = self
        settingsView.settingsPickerView.delegate = self

        loadTheCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        let selected = instanceOfUserPreferencesFromSettingsController.getTheRow()
//
//        //let parts = self.categories.firstIndex(of: selected)
//
//        settingsView.settingsPickerView.selectRow(selected, inComponent: 0, animated: true)
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
        return categories.count
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        let selectRow = categories[row].displayName
     //  var theSelect = instanceOfUserPreferencesFromSettingsController.getSavedCategory()

        return selectRow
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        

        instanceOfUserPreferencesFromSettingsController.saveTheCategory(categories[row], itemAt: row)
        


    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: categories[row].displayName, attributes: [NSAttributedString.Key.foregroundColor:UIColor.systemPurple])

    }
    
}
