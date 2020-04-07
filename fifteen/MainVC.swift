//
//  MainVC.swift
//  fifteen
//
//  Created by jason smellz on 4/6/20.
//  Copyright © 2020 jacob. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
        
    var story: UIStoryboard!
    var baseView = BaseView()
    var playerOverlay = PlayerOverlay()

//    var network = NetworkController.init()
    var websocket = Networking("ws://localhost:3000")
    var resourceUri = ""
    var playerData: PlayerData! {
        willSet(newValue) {
            
            // TODO: find a clever way to deal with this 
            // bambuser only
//            if newValue.resourceUri != resourceUri {
//                // reload playerView
//                baseView.playerView.resourceUri = newValue.resourceUri
//                baseView.reloadPlayerView()
//                self.resourceUri = newValue.resourceUri
//            }
            
            // if first new data create and start timer
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
            }
            
            playerOverlay.update(newValue)
            
            guard newValue.chosen == true else {return}
            setupForBroadcast()
        }
    }

    var timer: Timer?
    
    var currentState: BaseState! {
        willSet(newValue) {
            baseView.switchView(newValue)
            playerOverlay.switchState(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        network.delegate = self
        websocket.delegate = self
        
        view.addSubview(baseView)
        view.addSubview(playerOverlay)
        baseView.frame = view.frame
        playerOverlay.frame = view.frame
        
        currentState = .loading
        
        playerOverlay.nextButton.addTarget(self, action: #selector(nextButton), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func nextButton() {
        websocket.nextVote(hideNextButton)
    }
    
    func hideNextButton() {
        playerOverlay.nextButton.isHidden = true
    }
    
    func setupForBroadcast() {
        
        timer?.invalidate()
        timer = nil
        
        currentState = .broadcast
        
    }
    
    func openAuth() {
        present(story.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC, animated: true, completion: nil)
    }
    
    @objc func count() {

        let time = Calendar.current.dateComponents([.second, .minute, .hour], from: playerData.start, to: Date())
        
        var hour = String(time.hour ?? 0)
        var minute = String(time.minute ?? 0)
        var second = String(time.second ?? 0)

        if hour.count <= 1 {
            hour = "0\(hour)"
        }
        
        if minute.count <= 1 {
            minute = "0\(minute)"
        }
        
        if second.count <= 1 {
            second = "0\(second)"
        }
        
        playerOverlay.timeLabel.text = "\(hour):\(minute):\(second)"
        
    }
    
}
