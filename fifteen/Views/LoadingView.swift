//
//  LoadingVC.swift
//  fifteen
//
//  Created by jason smellz on 4/6/20.
//  Copyright © 2020 jacob. All rights reserved.
//

import Foundation
import AVKit

class LoadingView: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(white: 0.1, alpha: 1)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }

}
