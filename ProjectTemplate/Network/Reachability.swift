//
//  Reachability.swift
//  ProjectTemplate
//
//  Created by Vikas Kumar on 18/01/24.
//

import Network
import Foundation

protocol NotificationName {
    var name: Notification.Name { get }
}

extension RawRepresentable where RawValue == String, Self: NotificationName {
    var name: Notification.Name {
        return Notification.Name(rawValue)
    }
}

enum Notifications {
    enum Reachability: String, NotificationName {
        case connected
        case notConnected
    }
}

@objc final class AHReachability: NSObject {
    @objc static var shared = AHReachability()

    lazy private var monitor = NWPathMonitor()

    var isNetworkAvailable: Bool {
        monitor.currentPath.status == .satisfied
    }

    private override init() {
        super.init()
        startNetworkReachabilityObserver()
    }

    @objc func startNetworkReachabilityObserver() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                NotificationCenter.default.post(name: Notifications.Reachability.connected.name, object: nil)
            } else if path.status == .unsatisfied {
                NotificationCenter.default.post(name: Notifications.Reachability.notConnected.name, object: nil)
            }
        }
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
    
    @objc func stopNetworkReachabilityObserver() {
        monitor.cancel()
    }
}
