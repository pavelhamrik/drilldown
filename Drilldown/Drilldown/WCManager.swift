//
//  WCManager.swift
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
    
    
    private var validSession: WCSession? {
        
        if session?.paired == nil {
            print("WCSession not paired.")
        }
        if session?.watchAppInstalled == nil {
            print("Watch app not installed.")
        }
        
        if let session = session where session.paired && session.watchAppInstalled {
            return session
        }
        return nil
        
    }

    
    func sessionWatchStateDidChange(session: WCSession) {
        
        print("WCSession state did change.")
        
    }
    
    
    private var validReachableSession: WCSession? {
        
        if let session = validSession where session.reachable {
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
