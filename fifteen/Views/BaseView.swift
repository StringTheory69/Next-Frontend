//
//  BaseView.swift
//  fifteen
//
//  Created by jason smellz on 4/6/20.
//  Copyright © 2020 jacob. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    var loadingView: LoadingView!
    var playerView: PlayerView!
    var broadcastView: BroadcastView!
    var currentView: UIView?

    // bambuser only
    func reloadPlayerView() {
        if currentView != nil {
            removeView(currentView!)
        }
        playerView = PlayerView()
        currentView = playerView
        addView(playerView)
    }
    
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
