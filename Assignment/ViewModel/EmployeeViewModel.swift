//
//  EmployeeViewModel.swift
//  Assignment
//
//  Created by sysadmin on 01/03/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

class EmployeeViewModel: NSObject {
    
    public enum EmployeeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    private let dataProvider = DataProvider()
    public let employee : PublishSubject<Any> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<EmployeeError> = PublishSubject()

    //MARK:- Web API -
    func fetchEmpListWS() {
        
        loading.onNext(true)
        APIManager.executeGetRequest(url: Router.empList, completionHandler:
            { [weak self] (response: Result<EmployeeModel, RequestError>) in
            
            self?.loading.onNext(false)
                
            switch response {
            case .success(let empListFeed):
                
                if API.isSuccess(status: empListFeed.status) {
                    if let records = empListFeed.records {
                        self?.employee.onNext(records)
                        
                        self?.dataProvider.syncEmplList(records: records, taskContext: Utility.appDelegate().persistentContainer.viewContext, completionHandler: { _ in
                        })
                    }
                    
                } else {
                    print("Get Failure msg")
                }
                                
            case .failure(let faliure):
                print(faliure.localizedDescription)
                
                switch faliure {
                case .connectionError:
                    self?.error.onNext(.internetError("Check your Internet connection."))
                case .serverError:
                    self?.error.onNext(.serverMessage("Problem with connect with server"))
                default:
                    self?.error.onNext(.serverMessage("Unknown Error"))
                }
            }
        })
    }
    
    //MARK:- DB Operation -
    func fetchFromDB() {
        switch dataProvider.fetch() {
        case .success(let records):
            self.employee.onNext(records)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
