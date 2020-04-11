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
    var websocket = Networking("ws://js.local:8080")
    
    // bambuser hack
    var activeBroadcast = false
    var timer: Timer?
    
    // reset player
//    var streamData = StreamData() {
//        willSet(newValue) {
//            print("NEW STREAM")
//
//            guard activeBroadcast == false else {return}
//            currentState = .player
////            let twitchVC = story.instantiateViewController(withIdentifier: "TwitchStream")
////            add(twitchVC)
////            baseView.playerView.play(newValue.streamUri)
//        }
//    }

    var playerData = PlayerData() {
        willSet(newValue) {
            
            // if first new data create and start timer
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
            }
            
            playerOverlay.update(newValue)

        }
    }
    
    var currentState: BaseState! {
        willSet(newValue) {
            baseView.switchView(newValue)
            playerOverlay.switchState(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        websocket.delegate = self
        
//        view.addSubview(baseView)
        add(baseView)
        view.addSubview(playerOverlay)
//        baseView.view.frame = view.frame
        playerOverlay.frame = view.frame
        baseView.delegate = self
        
        currentState = .player
        
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
    
    func cancelBroadcast() {
        print("CANCEL")
        activeBroadcast = false
        currentState = .player
//        baseView.playerView.play(streamData.streamUri)
    }
    
    func newBroadcast(_ uri: String) {
        
        activeBroadcast = true
        
        let jsonString = """
        {
            "streamUri": "\(uri)"
        }
        """
        
        websocket.sendStreamStatus(jsonString)
        
        // need this for bambuser so that baseview doesn't switch to player view when its own resource uri is updated
//        activeResourceUri = uri
    }
    
    func openAuth() {
        present(story.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC, animated: true, completion: nil)
    }
    
    @objc func count() {
        
        let startDate = Date(timeIntervalSince1970: playerData.start)

        let time = Calendar.current.dateComponents([.second, .minute, .hour], from: startDate, to: Date())
        
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
