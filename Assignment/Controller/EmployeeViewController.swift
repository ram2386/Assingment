//
//  ViewController.swift
//  Assignment
//
//  Created by sysadmin on 01/03/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import UIKit
import SwiftOverlays
import RxSwift

class EmployeeViewController: UIViewController {

    enum Filter: Int {
        case alphabet = 0
        case age
    }
    
    @IBOutlet weak var tblView: UITableView!
    var employeeViewModel = EmployeeViewModel()
    private var viewFilters: [DPArrowMenuViewModel] = []
    let disposeBag = DisposeBag()
    var arrEmp = [Any]()
    var filter:Filter = Filter.alphabet

    //MARK:- View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    //MARK:- User Method -
    func initialSetup() {
        
        self.title = "Employee"
        setupFilter()
        setupBindings()
        
        if Utility.isInternet() {            
            employeeViewModel.fetchEmpListWS()
        } else {
            employeeViewModel.fetchFromDB()
        }
    }
    
    func setupFilter() {
        
        viewFilters.append(DPArrowMenuViewModel(title:"A-Z"))
        viewFilters.append(DPArrowMenuViewModel(title:"Age"))
    }
    
    func applyFilter() {
                
        if let records = arrEmp as? [Employee], records.count > 0 {
            if filter == .alphabet {
                arrEmp = records.sorted {$0.name! < $1.name!}
            } else {
                arrEmp = records.sorted {$0.age! < $1.age!}
            }
            
        } else if let records = arrEmp as? [EmployeeData], records.count > 0 {
            if filter == .alphabet {
                arrEmp = records.sorted {$0.name! < $1.name!}
            } else {
                arrEmp = records.sorted {$0.age! < $1.age!}
            }
        }
    }

    // MARK: - Bindings
    private func setupBindings() {
        //binding api to vc
        employeeViewModel.employee
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (empModel) in
                
                if let records = empModel as? [EmployeeData] {
                    self?.arrEmp.append(contentsOf: records)
                }
                
                if let records = empModel as? [Employee] {
                    self?.arrEmp.append(contentsOf: records)
                }
                
                self?.tblView.reloadData()
            })
            .disposed(by: disposeBag)
        
        //binding loading to vc
        employeeViewModel.loading
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        
        //observing errors to show
        employeeViewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internetError(let message):
                    MessageView.sharedInstance.showOnView(message: message, theme: .error)
                case .serverMessage(let message):
                    MessageView.sharedInstance.showOnView(message: message, theme: .warning)
                }
            })
            .disposed(by: disposeBag)
    }
    
    //MARK:- Button Action -
    @IBAction func clickOnFilter(_ sender: Any) {
        
        guard let btnInstance = sender as? UIButton else { return }
        
            DPArrowMenu.show(btnInstance, viewModels: viewFilters, done: { [weak self] index in
                let filterInstance = self?.viewFilters[index]
                btnInstance.setTitle(filterInstance?.title, for: .normal)
                self?.filter = Filter(rawValue: index)!
                self?.applyFilter()
                self?.tblView.reloadData()
        }) {
        }
    }
}

extension EmployeeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEmp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeListCell") as! EmployeeListCell
        
        let record = arrEmp[indexPath.row]
        cell.display(record: record)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = detailVC()
        controller.empRecord = arrEmp[indexPath.row]
        present(controller, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrEmp.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
