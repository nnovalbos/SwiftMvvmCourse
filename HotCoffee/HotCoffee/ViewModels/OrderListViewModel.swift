//
//  OrderListViewModel.swift
//  HotCoffee
//
//  Created by Nicolas Novalbos on 22/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation

class OrderListViewModel {
    
    var ordersViewModel : [OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
    
}

extension OrderListViewModel {
    
    func orderViewModel (at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }

}
