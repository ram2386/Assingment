//
//  EmployeeListCell.swift
//  Assignment
//
//  Created by sysadmin on 01/03/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import UIKit

class EmployeeListCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    func display(record: Any) {
        
        var empName = ""
        var strUrl = ""
        
        if let empModel = record as? EmployeeData {
            
            if let name = empModel.name {
                empName = name
            }
            
            if let imgUrl = empModel.profileImg, imgUrl.count > 0 {
                strUrl = imgUrl
            } else {
                strUrl = "https://www.plaxis.com/content/uploads/2016/08/dummy-user.png"
            }
            
        } else if let empModel = record as? Employee {
            
            if let name = empModel.name {
                empName = name
            }
            
            if let imgUrl = empModel.imgUrl, imgUrl.count > 0 {
                strUrl = imgUrl
            } else {
                strUrl = "https://www.plaxis.com/content/uploads/2016/08/dummy-user.png"
            }
        }
        
        lblName.text = empName
        imgProfile.loadImageUsingCacheWithURLString(strUrl, placeHolder: nil)
    }
}
