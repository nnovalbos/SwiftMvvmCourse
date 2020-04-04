//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by Nicolas Novalbos on 03/04/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation

enum Unit : String, CaseIterable {
    case celsius = "metric"
    case fahranheit = "imperial"
}

extension Unit {
    
    var displayName : String {
        get {
            switch (self) {
            case .celsius:
                return "Celsius"
            case .fahranheit:
                return "Fahrenheit"
            }
        }
    }
}

struct SettingsViewModel {
    let units = Unit.allCases
    
    private var _selectedUnit: Unit = .fahranheit
    
    var selectedUnit : Unit {
        get {
            if let unit = UserDefaults.standard.value(forKey: "unit") as? String {
                return Unit(rawValue: unit)!
            }
            
            return _selectedUnit
        }
        
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "unit")
        }
    }
}
