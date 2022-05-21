//
//  Helper.swift
//  InstaBosta
//
//  Created by Taha on 20/05/2022.
//

import Foundation
import SystemConfiguration

struct Helper {
           
    static func checkConnection () -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)

    }
    
    static func showSuccessNotification(message: String) {
        CRNotifications.showNotification(type: CRNotifications.success, title: "Success", message: message, dismissDelay: 3)
    }
    
    static func showErrorNotification(message: String) {
        CRNotifications.showNotification(type: CRNotifications.error, title: "Error", message: message, dismissDelay: 3)
    }
    
    static func showInfoNotification(title: String, message: String) {
        CRNotifications.showNotification(type: CRNotifications.info, title: title, message: message, dismissDelay: 3)
    }

}
