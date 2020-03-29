//
//  CoffeOrderViewController.swift
//  HotCoffee
//
//  Created by Nicolas Novalbos on 21/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation
import  UIKit

protocol AddCoffeOrderDelegate {
    
    func addCoffeOrderViewControllerDidSave(order: Order, controller: UIViewController)
    func addCoffeOrderViewControllerDidClose(controller: UIViewController)
}


class AddCoffeOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextFied: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func Close(){
        
        if let delegate = delegate{
            delegate.addCoffeOrderViewControllerDidClose(controller: self)
        }
    }
    
    @IBAction func Save(){
        SaveOrder()
    }
    
    private var coffeSizeSegmentedControl : UISegmentedControl!
    var delegate : AddCoffeOrderDelegate?
    
    private var vm = AddOrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeTypeCellIdentifier", for: indexPath)
        
        cell.textLabel?.text = vm.types[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    private func setUpUI(){
        self.coffeSizeSegmentedControl = UISegmentedControl(items: vm.sizes)
        
        self.coffeSizeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.coffeSizeSegmentedControl)
        
        self.coffeSizeSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
        self.coffeSizeSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    private func SaveOrder(){
        
        let name = self.nameTextFied.text
        let email = self.emailTextField.text
        
        let selectedSize = self.coffeSizeSegmentedControl.titleForSegment(at: self.coffeSizeSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("Coffe type is compulsory")
        }
        
        self.vm.name = name
        self.vm.email = email
        self.vm.selectedSize = selectedSize
        self.vm.selectedType =  self.vm.types[indexPath.row]
        
        
        WebService().load(resource: Order.create(vm: self.vm)) { result in
            
            switch result {
                case .success (let order):
                    
                    if let order = order, let delegate = self.delegate {
                        delegate.addCoffeOrderViewControllerDidSave(order: order, controller: self)
                    }
                
                case .failure(let error):
                    print(error)
            }
        }
        
    }
    
    
   
}
