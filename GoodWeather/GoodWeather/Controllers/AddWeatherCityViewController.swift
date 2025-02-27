//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by Nicolas Novalbos on 29/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation
import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {
    
    private var addCityVieModel = AddCityViewModel()
    
    @IBOutlet weak var cityName : BindingTextField! {
        
        didSet {
            
            cityName.bind { self.addCityVieModel.city = $0}
        }
    }
    
    @IBOutlet weak var stateName : BindingTextField! {
        didSet {
            
            stateName.bind { self.addCityVieModel.state = $0}
        }
    }
    @IBOutlet weak var zipCodeName : BindingTextField! {
        didSet {
            
            zipCodeName.bind { self.addCityVieModel.zipCode = $0}
        }
    }
    
    
    
    var delegate : AddWeatherDelegate?
    let API_KEY = "YOUR_API_KEY"
    
    @IBAction func Save(){
        
        print(addCityVieModel)
        
        if let cityName = cityName.text {
            let unit = UserDefaults.standard.value(forKey: "unit") as! String
            let weatherURL = URL (string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&APPID=\(API_KEY)&units=\(unit)")!
            let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { data in
                
                let weatherViewModel = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                
                return weatherViewModel;
            }
            
            Webservice().load(resource: weatherResource) { [weak self] result in
                
                if let weatherVM = result {
                    
                    if let delegate = self?.delegate {
                        delegate.addWeatherDidSave(vm: weatherVM)
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
            
        }
    }
    
    @IBAction func Close(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
