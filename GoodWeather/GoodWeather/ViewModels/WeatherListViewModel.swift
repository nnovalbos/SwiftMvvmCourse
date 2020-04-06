//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by Nicolas Novalbos on 31/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation

class WeatherListViewModel {

    private(set) var weatherViewModels = [WeatherViewModel]()
    
    func AddWeatherViewModel(_ vm: WeatherViewModel){
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
    
    func updateUnit(to unit: Unit) {
        switch unit {
        case .celsius:
            toCelsius()
        case .fahranheit:
            toFahranheit()
        }
    }
    
    private func toCelsius() {
        
        weatherViewModels = weatherViewModels.map { vm in
            let weatherVM = vm
            weatherVM.temperature.temperature.value = (weatherVM.temperature.temperature.value - 32) * 5/9
            return weatherVM
        }
    }
    
    private func toFahranheit() {
        
        weatherViewModels = weatherViewModels.map { vm in
            let weatherVM = vm
            weatherVM.temperature.temperature.value = (weatherVM.temperature.temperature.value * 9/5) + 32
            return weatherVM
        }
    }
}


//TypeEraser

class Dinamic<T>: Decodable where T: Decodable {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener){
        
        self.listener = listener
        self.listener?(self.value)
        
    }
    
    
    var value: T{
        didSet{
            
            listener?(value)
        }
    }
    
    private enum CodingKeys : CodingKey{
        case value
    }
    
}


struct WeatherViewModel : Decodable{
    
    let name: Dinamic<String>
    var temperature: TemperatureViewModel
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = Dinamic(try container.decode(String.self, forKey: .name))
        temperature = try container.decode(TemperatureViewModel.self, forKey: .temperature)
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case temperature = "main"
    }
    
}

struct TemperatureViewModel : Decodable {
    var temperature: Dinamic<Double>
    let temperatureMin: Dinamic<Double>
    let temperatureMax: Dinamic<Double>
    
    private enum CodingKeys: String, CodingKey {
           case temperature =  "temp"
           case temperatureMin = "temp_min"
           case temperatureMax = "temp_max"
    }
    
    init(from decoder: Decoder) throws {
    
         let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = Dinamic(try container.decode(Double.self, forKey: .temperature))
        temperatureMax = Dinamic(try container.decode(Double.self, forKey: .temperatureMax))
        temperatureMin = Dinamic(try container.decode(Double.self, forKey: .temperatureMin))
    }
}
