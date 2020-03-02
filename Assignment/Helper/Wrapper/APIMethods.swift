//
//  APIMethods.swift
//  Assignment
//
//  Created by sysadmin on 02/03/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import UIKit

struct API {
    
    struct Method {
        static let empList = "employees"
    }
}

extension API {
    
    static func isSuccess(status: String?) -> Bool {
        
        if let status = status,
        status == APIResult.success.rawValue {
            return true
        } else {
            return false
        }
    }
}
