//
//  Networking.swift
//  fifteen
//
//  Created by jason smellz on 4/6/20.
//  Copyright © 2020 jacob. All rights reserved.
//

import Foundation

class Networking: NSObject, URLSessionWebSocketDelegate {
    
    var urlSession: URLSession!
    var webSocketTask: URLSessionWebSocketTask?
    var socketUrl: URL!
    var delegate: MainVC!

    init(_ urlString: String) {
        super.init()
        self.socketUrl = URL(string: urlString)
        openConnection(URL(string: urlString)!)
    }
    
    func openConnection(_ url: URL) {
        
        if urlSession != nil {
            urlSession = nil
        }
        
        if webSocketTask != nil {
            webSocketTask?.cancel(with: .goingAway, reason: nil)
            webSocketTask = nil
        }
        
        urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask!.resume()

        attachListener()
        sendPing()
    }
    
    @objc func nextVote(_ completion: @escaping () -> ()) {
        let message = URLSessionWebSocketTask.Message.string("next")
        webSocketTask!.send(message) { error in
          if let error = error {
            print("WebSocket couldn’t send message because: \(error)")
          } else {
                completion()
            }
        }
    }
    
    // receive incoming messages
    func attachListener() {
        webSocketTask!.receive { result in
            
        switch result {
            
        case .failure(let error):
            print("Error in receiving message: \(error)")
        case .success(let message):

            switch message {
            case .string(let text):
                print("Received string: \(text)")
                
                let decoder = JSONDecoder()
                
                if text.contains("chosen") {
                    print(text)
                    // start broadcast
                    self.delegate.setupForBroadcast()
                    
                } else if text.contains("cancel") {
                    
                    self.delegate.cancelBroadcast()
                    
// \\\\\\\\\\\\\\\\\
                } else {
                    // upload new player data 
                    do {
                        let playerData = try decoder.decode(PlayerData.self, from: Data(text.utf8))
                        print(playerData)
                        self.delegate.playerData = playerData
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
                
            case .data(let data):
                print("Received data: \(data)")
            }
          
          self.attachListener()
        }
      }
    }

    // keep the connection active with the server
    func sendPing() {
        webSocketTask!.sendPing { (error) in
        if let error = error {
          print("Sending PING failed: \(error)")
        }
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
          self.sendPing()
        }
      }
    }
    
    // send out stream active message when stream begins
    func sendStreamStatus(_ status: String) {
        let message = URLSessionWebSocketTask.Message.string(status)
        webSocketTask!.send(message) { error in
          if let error = error {
            print("WebSocket couldn’t send message because: \(error)")
          } 
        }
    }
    
    // close connection
    func closeConnection() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    // monitor connection status - delegate functions
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("connection established")
    }

    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        // restart connection if not intentional
        print("connection disconnected")
        
//        closeConnection()
//        openConnection(socketUrl)
    }
    
}
