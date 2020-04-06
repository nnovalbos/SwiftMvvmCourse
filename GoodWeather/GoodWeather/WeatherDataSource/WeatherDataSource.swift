//
//  WeatherDataSource.swift
//  GoodWeather
//
//  Created by Nicolas Novalbos on 05/04/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation
import UIKit

class WeatherDataSource: NSObject, UITableViewDataSource {
   
    let cellIdentifier: String
    private var weatherListViewModel: WeatherListViewModel
    
    init(cellIdentifier: String, weatherListViewModel: WeatherListViewModel) {
        self.cellIdentifier = cellIdentifier
        self.weatherListViewModel = weatherListViewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.weatherViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? WeatherCell else {
            fatalError("Cell with identifier \(self.cellIdentifier) not foud")
        }
        
        let weatherVM = self.weatherListViewModel.viewModel(atIndex: indexPath.row)
        cell.cityNameLabel.text = weatherVM?.name.value
        cell.temperatureLabel.text = weatherVM?.temperature.temperature.value.formatDegree
        return cell
        
    }
    
    
}
