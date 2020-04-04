//
//  Double+Extensions.swift
//  GoodWeather
//
//  Created by Nicolas Novalbos on 31/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation

extension Double {
    
    var formatDegree : String {
        return String(format: "%.0fº", self)
    }
}
