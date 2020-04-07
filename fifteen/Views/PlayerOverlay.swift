//
//  PlayerOverlay.swift
//  fifteen
//
//  Created by jason smellz on 4/5/20.
//  Copyright © 2020 jacob. All rights reserved.
//

import UIKit

class PlayerOverlay: UIView {
    
    lazy var timeLabel: UILabel = {
        var timeLabel = UILabel()
        timeLabel.backgroundColor = .mainRed
        timeLabel.text = "00:00:00"
        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
        return timeLabel
    }()
    
    lazy var profileImageView: UIImageView = {
        var profileImageView = UIImageView()
        profileImageView.backgroundColor = .white
        return profileImageView
    }()
    
    lazy var votesView: NextSliderView = {
        var votesView = NextSliderView()
        return votesView
    }()
    
    lazy var votesLabel: UILabel = {
        var votesLabel = UILabel()
        votesLabel.font = .small
        votesLabel.textAlignment = .center
        votesLabel.textColor = .white
//        votesLabel.text = "0"
        return votesLabel
    }()
    
    lazy var viewersIcon: UIImageView = {
        var viewersIcon = UIImageView()
        viewersIcon.contentMode = .scaleAspectFit
        viewersIcon.image = #imageLiteral(resourceName: "views_icon")
        return viewersIcon
    }()
    
    lazy var viewersLabel: UILabel = {
        var viewersLabel = UILabel()
        viewersLabel.font = .small
        viewersLabel.textAlignment = .center
        viewersLabel.textColor = .white
//        viewersLabel.text = "0"
        return viewersLabel
    }()
    
    lazy var shareIcon: UIView = {
        var shareIcon = UIView()
        shareIcon.backgroundColor = .white
        return shareIcon
    }()
    
    lazy var shareLabel: UILabel = {
        var shareLabel = UILabel()
        shareLabel.font = .small
        shareLabel.textAlignment = .center
//        shareLabel.textColor = .clear
//        shareLabel.text = "0"
        return shareLabel
    }()
    
    lazy var nextButton: UIButton = {
        var nextButton = UIButton()
        nextButton.backgroundColor = .mainRed
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle("NEXT", for: .normal)
//        nextButton.isHidden = true
        return nextButton
    }()
    
    var timer: Timer?
    var startDate: Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    func switchState(_ currentState: BaseState) {
        
        switch currentState {
            
            case .loading: do {
                isHidden = true
            }
            
            case .player: do {
                nextButton.isHidden = false
            }
            
            case .broadcast: do {
                nextButton.isHidden = true
            }
            
        }
        
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    fileprivate func setupViews() {
        
        addSubview(timeLabel)
        addSubview(profileImageView)
        addSubview(votesView)
        addSubview(votesLabel)
        addSubview(viewersIcon)
        addSubview(viewersLabel)
        addSubview(shareIcon)
        addSubview(shareLabel)
        addSubview(nextButton)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        votesView.translatesAutoresizingMaskIntoConstraints = false
        votesLabel.translatesAutoresizingMaskIntoConstraints = false
        viewersIcon.translatesAutoresizingMaskIntoConstraints = false
        viewersLabel.translatesAutoresizingMaskIntoConstraints = false
        shareIcon.translatesAutoresizingMaskIntoConstraints = false
        shareLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // time label
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 14
        
        // votes view
        votesView.layer.masksToBounds = true
        votesView.layer.cornerRadius = 13
        
        // profile Image View
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 23
        
        // next button
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 25
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
        }
    }
    
    fileprivate func setupLayout() {
        NSLayoutConstraint.activate([
            
            // time label
            timeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            timeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            timeLabel.widthAnchor.constraint(equalToConstant: 114),
            timeLabel.heightAnchor.constraint(equalToConstant: 28),
            
            // profile Image View
            profileImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 46),
            profileImageView.heightAnchor.constraint(equalToConstant: 0),

            
            // votes View
            votesView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 25),
            votesView.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            votesView.bottomAnchor.constraint(equalTo: votesLabel.topAnchor, constant: -10),
            votesView.widthAnchor.constraint(equalToConstant: 26),
            
            // votes Label
            votesLabel.bottomAnchor.constraint(equalTo: viewersIcon.topAnchor, constant: -15),
            votesLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),

            // votes icon
            viewersIcon.bottomAnchor.constraint(equalTo: viewersLabel.topAnchor, constant: -5),
            viewersIcon.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            viewersIcon.heightAnchor.constraint(equalToConstant: 19),

            // votes label
            viewersLabel.bottomAnchor.constraint(equalTo: shareIcon.topAnchor, constant: -15),
            viewersLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            
            // share icon
            shareIcon.bottomAnchor.constraint(equalTo: shareLabel.topAnchor, constant: -5),
            shareIcon.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            shareIcon.heightAnchor.constraint(equalToConstant: 19),

            // share label
            shareLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -15),
            shareLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            
            // next button
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
        ])
    }
    
    @objc func count() {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        
        guard startDate != nil else {return}
        guard Calendar.current.dateComponents([.second, .minute, .hour], from: startDate!, to: now) != nil else {return}
        let time = Calendar.current.dateComponents([.second, .minute, .hour], from: startDate!, to: now)
        var hour: String
        var minute: String
        var second: String

        if (time.hour?.description.count)! > 1 {
            hour = (time.hour?.description)!
        } else {
            hour = "0\((time.hour?.description)!)"
        }
        
        if (time.minute?.description.count)! > 1 {
            minute = (time.minute?.description)!
        } else {
            minute = "0\((time.minute?.description)!)"
        }
        
        if (time.second?.description.count)! > 1 {
            second = (time.second?.description)!
        } else {
            second = "0\((time.second?.description)!)"
        }
        
        timeLabel.text = "\(hour):\(minute):\(second)"
        
    }
    
    func update(_ playerData: PlayerData) {
        votesLabel.text = playerData.votes.description
        viewersLabel.text = playerData.viewers.description
        startDate = playerData.start
        print("PERCENT", Float(playerData.votes), Float(playerData.viewers))
        print("PERCENT", Float(playerData.votes)/Float(playerData.viewers))
        if Double(playerData.votes) == 0.0 {
            votesView.sliderAnimate(0.0)

        } else {
            var viewers = playerData.viewers
            if playerData.viewers >= 2 {
                viewers = playerData.viewers/2
            }
            votesView.sliderAnimate(Double(playerData.votes)/Double(viewers))
        }
    }
    
}
