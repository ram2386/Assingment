//
//  EmployeeModel.swift
//  Assignment
//
//  Created by sysadmin on 01/03/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import Foundation

struct EmployeeModel: Decodable {
    var status: String?
    var records: [EmployeeData]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case records = "data"
    }
}

struct EmployeeData: Decodable {
    var id: String?
    var name: String?
    var salary: String?
    var age: String?
    var profileImg: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "employee_name"
        case salary = "employee_salary"
        case age = "employee_age"
        case profileImg = "profile_image"
    }
}

