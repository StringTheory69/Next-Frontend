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

    var network = NetworkController.init()
    var data = ContainerData()
    
    var currentState: BaseState! {
        willSet(newValue) {
            baseView.switchView(newValue)
            playerOverlay.switchState(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        network.delegate = self
                
//        view.backgroundColor = .red
        
        view.addSubview(baseView)
        baseView.frame = view.frame
        view.addSubview(playerOverlay)
        playerOverlay.frame = view.frame
        currentState = .loading
        
        playerOverlay.nextButton.addTarget(network, action: #selector(network.nextAction), for: UIControl.Event.touchUpInside)
//        playerOverlay.translatesAutoresizingMaskIntoConstraints = false
//        setupLayout()
        
    }
    
    fileprivate func setupLayout() {
        NSLayoutConstraint.activate([
            playerOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            playerOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func openAuth() {
        present(story.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC, animated: true, completion: nil)
    }
    
}

class BaseView: UIView {
    
    var loadingView: LoadingView!
    var playerView: PlayerView!
    var broadcastView: BroadcastView!
    var currentView: UIView?

    
    func switchView(_ currentState: BaseState) {
        
        if currentView != nil {
            removeView(currentView!)
        }
        
        switch currentState {
            
            case .loading: do {
                loadingView = LoadingView()
                currentView = loadingView
                addView(loadingView)
            }
            
            case .player: do {
                playerView = PlayerView()
                currentView = playerView
                addView(playerView)
            }
            
            case .broadcast: do {
                broadcastView = BroadcastView()
                currentView = broadcastView
                addView(broadcastView)
            }
            
        }
        
    }
    
    func addView(_ newView: UIView) {
        addSubview(newView)
        newView.frame = frame
    }
    
    func removeView(_ oldView: UIView) {
        oldView.removeFromSuperview()
    }

}
