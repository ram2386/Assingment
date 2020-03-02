//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by sysadmin on 02/03/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import XCTest
@testable import Assignment

class AssignmentTests: XCTestCase {
    
    var empController: EmployeeViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        empController = UIStoryboard.main().instantiateViewController(withIdentifier: String(describing: EmployeeViewController.self)) as? EmployeeViewController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        empController = nil
        super.tearDown()
    }
    
    func testPerformanceOfApplyFilter() {
        
        empController.arrEmp = [EmployeeData]()
        empController.filter = .age
        
        do {
            if let file = Bundle.main.url(forResource: "csvjson", withExtension: "json") {
         
                let data = try Data(contentsOf: file, options: .alwaysMapped)
                let empModel = try JSONDecoder().decode(EmployeeModel.self, from: data)
                
                if let records = empModel.records {
                    empController.arrEmp.append(contentsOf: records)
                }
                
            } else {
                print("no file found")
                XCTFail("no file found")
            }
        } catch {
            print(error.localizedDescription)
            XCTFail("Failed : \(error.localizedDescription)")
        }
        
        measure {
            empController.applyFilter()
        }
    }
    
    func testCallForCheckingAPIRequestResponse() {
        
        let promise = expectation(description: "Getting Response")
        
        APIManager.testAPIs(url: "\(URLs.serverURL)\(API.Method.empList)") { (response: Result<Data?, Error>) in
            switch response {
            case .success(_):
                promise.fulfill()
            case .failure(let error):
                XCTFail("Failed : \(error.localizedDescription)")
            }
        }
        
        wait(for: [promise], timeout: 2)
    }
    
    func testCallForFailedAPIRequest() {

        let promise = expectation(description: "Getting Response")

        APIManager.testAPIs(url: "\(URLs.serverURL)wrong") { (response: Result<Data?, Error>) in
            switch response {
            case .success(_):
                promise.fulfill()
            case .failure(let error):
                XCTFail("Failed : \(error.localizedDescription)")
            }
        }

        wait(for: [promise], timeout: 2)
    }
}
