//
//  EmptyView.swift
//  NYTBooks-Group-Project
//
//  Created by Tanya Burke on 2/18/20.

//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
        
        public lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.textAlignment = .center
            label.font = UIFont.preferredFont(forTextStyle: .headline)
            return label
        }()
        
        public lazy var messageLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 4
            label.textAlignment = .center
            label.font = UIFont.preferredFont(forTextStyle: .subheadline)
            return label
        }()
        
        init(title: String, message: String){
            super.init(frame: UIScreen.main.bounds)
            titleLabel.text = title
            messageLabel.text = message
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        private func commonInit(){
            setUpMessageLabelConstraints()
            setUpTitleLabelConstraints()
        }
        
        private func setUpMessageLabelConstraints() {
            addSubview(messageLabel)
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor), messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8), messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)])
        }
        
        private func setUpTitleLabelConstraints() {
            addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([titleLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8), titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8), titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)])
        }
    
    }


}

