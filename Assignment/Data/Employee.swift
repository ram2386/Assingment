//
//  EmployeeFeed.swift
//  Assignment
//
//  Created by sysadmin on 02/03/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import CoreData

@objc(Employee)
class Employee: NSManagedObject, CoreModel {
    
    typealias entity = Employee
    
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var salary: String?
    @NSManaged public var age: String?
    @NSManaged public var imgUrl: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: Entity.employee)
    }
    
    func update(with model: EmployeeData) {

        self.id = model.id ?? ""
        self.name = model.name ?? ""
        self.salary = model.salary ?? ""
        self.age = model.age ?? ""
        self.imgUrl = model.profileImg ?? ""
    }
}

extension Employee {
  
  public static var entityName: String {
    return String(describing: Employee.self)
  }
  
  public static var request: NSFetchRequest<entity> {
    return NSFetchRequest<entity>(entityName: entityName)
  }

  public static func performFetchRequest() -> NSFetchRequest<entity> {
    return NSFetchRequest<entity>(entityName: entityName)
  }
}
