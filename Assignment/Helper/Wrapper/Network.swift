//
//  Network.swift
//  NewsFeed
//
//  Created by sysadmin on 16/02/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum RequestError: Error {
    case unknownError
    case connectionError
    case serverError
}

enum APIResult: String {
    case success = "success"
    case failure = ""
}

enum Router: URLConvertible {
    
    case empList
            
    func asURL() throws -> URL {
        
        var path = URLs.serverURL
        
        switch self {
        case .empList:
            path += "\(API.Method.empList)"
        }
        
        let url = URL(string: path)
        
        return url!
    }
}

final class APIManager {
    
    static func executeGetRequest<T: Decodable>(url: URLConvertible,
                                                completionHandler: @escaping (Result<T, RequestError>) -> ()) {

        if Utility.isInternet() == false {
            completionHandler(.failure(RequestError.connectionError))
        } else {
        
            AF.request(url)
            .validate()
            .responseDecodable(of: T.self) { response in
                
                if let newsFeed = response.value {
                    completionHandler(.success(newsFeed))
                } else {
                    completionHandler(.failure(errorHandler(response.response!.statusCode)))
                }
            }
        }
    }
    
    static func testAPIs(url: String, completionHandler: @escaping (Result<Data?, RequestError>) -> ()) {

        if Utility.isInternet() == false {
            completionHandler(.failure(RequestError.connectionError))
        } else {
        
            AF.request(url)
            .validate()
            .responseJSON { (response) in
                
                if let _ = response.value {
                    completionHandler(.success(response.data))
                } else {
                    completionHandler(.failure(errorHandler(response.response!.statusCode)))
                }
            }
        }
    }
}

extension APIManager {
    
    static func errorHandler(_ statusCode: Int) -> RequestError {
        
        switch statusCode {
        case 500...599:
            return .serverError
        default:
            return .unknownError
        }
    }
}
