//
//  WCWatchManager.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 24.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import WatchConnectivity

class WCManager: NSObject, WCSessionDelegate {
    
    
    static let sharedManager = WCManager()
    private override init() {
        
        super.init()
        
    }
    
    
    private let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
    
    
    func startSession() {
        
        session?.delegate = self
        session?.activateSession()
        
    }
    
    
    func sessionWatchStateDidChange(session: WCSession) {
        
        print("WCSession state did change.")
        
    }
    
    
    private var validReachableSession: WCSession? {
        
        if let session = session where session.reachable {
            return session
        }
        
        return nil
        
    }
    
    
    func sessionReachabilityDidChange(session: WCSession) {
        
        if session.reachable {
            print("WCSession is reachable.")
        } else {
            print("WCSession no longer reachable.")
        }
        
    }
    
    
}
