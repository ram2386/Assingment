//
//  DetailViewController.swift
//  Assignment
//
//  Created by sysadmin on 02/03/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import UIKit
import BottomPopup

class DetailViewController: BottomPopupViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lblAge: UILabel!    
    var empRecord: Any?
    
    override var popupHeight: CGFloat {
        return CGFloat(200)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        var name: String?
        var salary: String?
        var age: String?
        
        if let item = empRecord as? EmployeeData {
            name = item.name
            salary = item.salary
            age = item.age
        }
        
        if let item = empRecord as? Employee {
            name = item.name
            salary = item.salary
            age = item.age
        }
        
        lblName.text = "Name: \(name ?? "")"
        lblSalary.text = "Salary: \(salary ?? "")"
        lblAge.text = "Age: \(age ?? "")"
    }

    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
