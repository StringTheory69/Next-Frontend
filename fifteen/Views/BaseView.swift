//
//  BaseView.swift
//  fifteen
//
//  Created by jason smellz on 4/6/20.
//  Copyright © 2020 jacob. All rights reserved.
//

import UIKit
import WebKit
import TwitchPlayer

class BaseView: UIViewController {
    var story: UIStoryboard!
    var loadingView: LoadingView!
    var playerVC: UIViewController!
    var broadcastView: BroadcastVC!
    var currentView: UIViewController?

    
    var delegate: MainVC!
    
    func switchView(_ currentState: BaseState) {
        
        if currentView != nil {
            currentView?.remove()
        }
                
        switch currentState {
            
            case .loading: do {
                loadingView = LoadingView()
                currentView = loadingView
                addView(loadingView.view)
            }
            
            case .player: do {
                playerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TwitchStream")
                currentView = playerVC
                addView(playerVC.view)
            }
            
            case .broadcast: do {
                broadcastView = BroadcastVC()
                currentView = broadcastView
                addView(broadcastView.view)
                

                broadcastView.delegate = delegate
            }
            
        }
        
    }
    
    func addView(_ newView: UIView) {
        view.addSubview(newView)
        newView.frame = view.frame
    }
    
    func removeView(_ oldView: UIView) {
        oldView.removeFromSuperview()
    }

}
