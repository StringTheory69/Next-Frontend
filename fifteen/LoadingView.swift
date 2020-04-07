//
//  LoadingVC.swift
//  fifteen
//
//  Created by jason smellz on 4/6/20.
//  Copyright © 2020 jacob. All rights reserved.
//

import Foundation

class LoadingView: UIView {
    
    lazy var loadingLabel: UILabel = {
        var loadingLabel = UILabel()
        loadingLabel.text = "Loading..."
        loadingLabel.textColor = .white
        return loadingLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                        
        backgroundColor = .red
        
        // storyboard setup
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        addSubview(loadingLabel)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func setupLayout() {
        NSLayoutConstraint.activate([
            
            loadingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
}
