//
//  Urls.swift
//  NewsFeed
//
//  Created by sysadmin on 16/02/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import Foundation

struct URLs {
    
    static var serverURL: String  {
     
        #if DEVELOPEMENT
            return "http://dummy.restapiexample.com/api/v1/"
        #else
            return "http://dummy.restapiexample.com/api/v1/"
        #endif
    }
}
