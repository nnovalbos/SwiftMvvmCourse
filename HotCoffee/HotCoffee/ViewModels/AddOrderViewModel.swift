//
//  AddOrderViewModel.swift
//  HotCoffee
//
//  Created by Nicolas Novalbos on 22/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation

struct AddOrderViewModel {
    
    var name: String?
    var email : String?
    var selectedSize: String?
    var selectedType: String?
    
    var types: [String] {
        return CoffeType.allCases.map{$0.rawValue.capitalized}
    }
    
    var sizes: [String] {
        return CoffeSize.allCases.map{$0.rawValue.capitalized}
    }
    
}
