//
//  NetworkReachability.swift
//  surdo
//
//  Created by Rustem Orazbayev on 1/27/24.
//

import UIKit
import SystemConfiguration

public class NetworkReachability: UIViewController {
    let reachability = SCNetworkReachabilityCreateWithName(nil, "https://startios.kz/privacy")

    func checkNetworkConnection() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        guard let reachability = self.reachability else {
            fatalError("SCNetworkReachabilityCreateWithName failed")
        }

        guard SCNetworkReachabilityGetFlags(reachability, &flags) else {
            fatalError("SCNetworkReachabilityGetFlags failed")
        }
        return isNetworkReachability(with: flags)
    }

    func isNetworkReachability(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand)
        || flags.contains(SCNetworkReachabilityFlags.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically
        && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection) || canConnectWithoutUserInteraction
    }
}
