//
//  Utility.swift
//  NewsFeed
//
//  Created by sysadmin on 24/02/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import Foundation
import Alamofire

class Utility {
    
    static func isInternet() -> Bool {
        if NetworkReachabilityManager()!.isReachable {
            return true
        } else {
            return false
        }
    }

    static func appDelegate() -> AppDelegate {
        return UIApplication.self.shared.delegate as! AppDelegate
    }
    
    static func addAspectRatioConstraint(view: UIView, width: CGFloat, height: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: view,
                                              attribute: NSLayoutConstraint.Attribute.height,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: view,
                                              attribute: NSLayoutConstraint.Attribute.width,
                                              multiplier: height / width,
                                              constant: 0))
    }
}
