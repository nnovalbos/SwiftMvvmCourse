//
//  WeatherDetailsViewController.swift
//  GoodWeather
//
//  Created by Nicolas Novalbos on 05/04/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet weak var cityName : UILabel!
    @IBOutlet weak var currentTemperatureLabel : UILabel!
    @IBOutlet weak var maxTemperatureLabel : UILabel!
    @IBOutlet weak var minTemperatureLabel : UILabel!
    
    var weatherViewModel: WeatherViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinding()
    }
    
    private func setUpBinding(){
        
        if let weatherViewModel = weatherViewModel {
            
            weatherViewModel.name.bind {self.cityName.text = $0 }
            weatherViewModel.temperature.temperature.bind {self.currentTemperatureLabel.text = $0.formatDegree }
            weatherViewModel.temperature.temperatureMax.bind {self.maxTemperatureLabel.text = $0.formatDegree }
            weatherViewModel.temperature.temperatureMax.bind {self.minTemperatureLabel.text = $0.formatDegree }
        }
        
        //change value after 2 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.weatherViewModel?.name.value = "Fake City"
        }
        
    }
    
}
