//
//  CoffeeOrderListViewController.swift
//  HotCoffee
//
//  Created by Nicolas Novalbos on 21/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation
import UIKit

class  CoffeeOrderListViewController: UITableViewController, AddCoffeOrderDelegate {
   
    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    //AddCoffeOrderDelegate methods
    func addCoffeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
           
         controller.dismiss(animated: true, completion: nil)
        
        var vm = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(vm)
        self.tableView.insertRows(at: [IndexPath(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
        
    }
       
    func addCoffeOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    //
    
    private func populateOrders(){
        
        
        WebService().load(resource: Order.all) { [weak self]result in
            
            switch result{
                case .success(let orders):
                    self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vm = orderListViewModel.orderViewModel(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellIdentifier", for: indexPath)
        
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController,
            let addCoffeVC = navigationVC.viewControllers.first as? AddCoffeOrderViewController else {
                fatalError("Error performing segue")
        }
        
        addCoffeVC.delegate = self
    }
}
