//
//  WeatherCell.swift
//  GoodWeather
//
//  Created by Nicolas Novalbos on 30/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation
import UIKit


class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel : UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(_ vm: WeatherViewModel){
        
        self.cityNameLabel.text = vm.name.value
        self.temperatureLabel.text = "\(vm.temperature.temperature.value.formatDegree)"
    }
}
