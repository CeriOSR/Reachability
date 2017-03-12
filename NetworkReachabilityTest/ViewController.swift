//
//  ViewController.swift
//  NetworkReachabilityTest
//
//  Created by Rey Cerio on 2017-03-09.
//  Copyright © 2017 CeriOS. All rights reserved.
//

import UIKit
import ReachabilitySwift   //1. importing the library

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//2. create a class of type NSObject and declare a shared instance variable
class ReachabilityManager: NSObject {
    static let shared = ReachabilityManager()  //shared instance
    
    //3. declare the variable that tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus : Reachability.NetworkStatus = .notReachable
    
    //4. Bool to track network reachability
    var isNetworkAvailable: Bool {
        return reachabilityStatus != .notReachable
    }
    
    // 5. Reachability instance for Network status monitoring
    let reachability = Reachability()!
    
    ///6. Called whenever there is a change in NetworkReachibility Status
    ///
    /// — parameter notification: Notification with the Reachability instance
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
    }
    
    ///7. Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name: ReachabilityChangedNotification, object: reachability)
        
        do{
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: ReachabilityChangedNotification,
                                                  object: reachability)
    }
}






















