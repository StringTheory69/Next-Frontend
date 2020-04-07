//
//  NextSlider.swift
//  fifteen
//
//  Created by jason smellz on 4/6/20.
//  Copyright © 2020 jacob. All rights reserved.
//

import UIKit

class NextSliderView: UIView {
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.mainRed.withAlphaComponent(0.3).cgColor, UIColor.mainRed.cgColor]
        return gradient
    }()
    
    lazy var nextsLevel: UIView = {
        var nextsLevel = UIView()
        return nextsLevel
    }()
    
    var sliderHeightConstraint: NSLayoutConstraint!
    var fullHeight: CGFloat = 0.0
    var percent = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(white: 0, alpha: 0.32)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var subviewsLoaded = false
    
    func sliderAnimate(_ percent: Double) {
        self.percent = percent
        guard subviewsLoaded == true else {return}
        UIView.animate(withDuration: 1, animations: {
            self.sliderHeightConstraint.constant = -(self.fullHeight*CGFloat(percent))
        }) { (success) in
            self.layoutIfNeeded()
        }
    }
    
    fileprivate func setupViews() {
        
        addSubview(nextsLevel)
        nextsLevel.translatesAutoresizingMaskIntoConstraints = false
        layer.addSublayer(gradient)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fullHeight = self.frame.height
        print("HEIGHT", fullHeight)
        nextsLevel.layer.masksToBounds = true
        nextsLevel.layer.cornerRadius = 14
        gradient.frame = nextsLevel.frame
        subviewsLoaded = true
        sliderAnimate(percent)
    }
    
    fileprivate func setupLayout() {
        NSLayoutConstraint.activate([

            // nexts level view
            nextsLevel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nextsLevel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nextsLevel.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            
        ])
        
        sliderHeightConstraint = nextsLevel.topAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        sliderHeightConstraint.isActive = true
    }
}
