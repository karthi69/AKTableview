//
//  AKReachabilityManager.swift
//  AKTableview
//
//  Created by Karthi Anandhan on 23/09/18.
//  Copyright © 2018 karthi. All rights reserved.
//

import Foundation


import Foundation
import ReachabilitySwift

/// Protocol for listenig network status change from other classes
public protocol AKNetworkStatusListener : class {
    func networkStatusDidChange(status: Reachability.NetworkStatus)
}


class AKReachabilityManager {
    static let shared = AKReachabilityManager()
    let reachability = Reachability()!
    var listeners = [AKNetworkStatusListener]()
    var isNetworkAvailable : Bool {
        return reachability.currentReachabilityStatus != .notReachable
    }
    
    @objc
    func reachabilityChanged(notification: Notification) {
        
        let reachability = notification.object as! Reachability
        
        switch reachability.currentReachabilityStatus {
        case .notReachable:
            debugPrint("Network became unreachable")
        case .reachableViaWiFi:
            debugPrint("Network reachable through WiFi")
        case .reachableViaWWAN:
            debugPrint("Network reachable through Cellular Data")
        }
        
        // Sending message to each of the delegates
        for listener in listeners {
            listener.networkStatusDidChange(status: reachability.currentReachabilityStatus)
        }
    }
    
    func startMonitoring() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            debugPrint("Could not start reachability notifier")
        }
    }
    
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification,
                                                  object: reachability)
    }
    
    func addListener(listener: AKNetworkStatusListener){
        listeners.append(listener)
    }
    
    func removeListener(listener: AKNetworkStatusListener){
        listeners = listeners.filter{ $0 !== listener}
    }
}
