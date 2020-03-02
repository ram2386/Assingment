//
//  MainCoordinate.swift
//  Assignment
//
//  Created by sysadmin on 02/03/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {

    static func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIViewController {
    
    func detailVC() -> DetailViewController {
        return UIStoryboard.main().instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as! DetailViewController
    }
}
