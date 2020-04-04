//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by Nicolas Novalbos on 31/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation

struct WeatherListViewModel {

    private var weatherViewModels = [WeatherViewModel]()
    
    mutating func AddWeatherViewModel(_ vm: WeatherViewModel){
        self.weatherViewModels.append(vm)
    }
    
    func numberOfWeatherViewModels () -> Int {
        return self.weatherViewModels.count
    }
    
    func viewModel(atIndex index: Int) -> WeatherViewModel? {
        
        if index < 0 || weatherViewModels.count < index {
            return nil
        }
        
        return self.weatherViewModels[index]
    }
    
    mutating func updateUnit(to unit: Unit) {
        switch unit {
        case .celsius:
            toCelsius()
        case .fahranheit:
            toFahranheit()
        }
    }
    
    private mutating func toCelsius() {
        
        weatherViewModels = weatherViewModels.map { vm in
            var weatherVM = vm
            weatherVM.temperature.temperature = (weatherVM.temperature.temperature - 32) * 5/9
            return weatherVM
        }
    }
    
    private mutating func toFahranheit() {
        
        weatherViewModels = weatherViewModels.map { vm in
            var weatherVM = vm
            weatherVM.temperature.temperature = (weatherVM.temperature.temperature * 9/5) + 32
            return weatherVM
        }
    }
}

struct WeatherViewModel : Decodable{
    
    let name: String
    var temperature: TemperatureViewModel
    
    private enum CodingKeys: String, CodingKey {
        case name
        case temperature = "main"
    }
    
}

struct TemperatureViewModel : Decodable {
    var temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    private enum CodingKeys: String, CodingKey {
           case temperature =  "temp"
           case temperatureMin = "temp_min"
           case temperatureMax = "temp_max"
    }
}
