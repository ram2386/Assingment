//
//  CoreModel.swift
//  Assignment
//
//  Created by sysadmin on 02/03/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import UIKit
import CoreData

protocol CoreModel {
    associatedtype entity: NSManagedObject
}

struct Entity {
    static let employee = "Employee"
}
