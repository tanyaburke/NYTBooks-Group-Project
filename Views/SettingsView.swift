//
//  SettingsView.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    public lazy var settingsPickerView: UIPickerView = {
        let picker = UIPickerView()
        let pv = UIPickerView(frame: CGRect.zero)
        pv.backgroundColor = .systemPink
        return pv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setupSettingsPickerView()
    }
    
    private func setupSettingsPickerView() {
        addSubview(settingsPickerView)
        settingsPickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsPickerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            settingsPickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            settingsPickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            settingsPickerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
