//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by Nicolas Novalbos on 29/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController, AddWeatherDelegate, SettingsDelegate {
   

    private var weatherListViewModel = WeatherListViewModel()
    private var dataSource : TableViewDataSource<WeatherCell,WeatherViewModel>!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.dataSource = TableViewDataSource(cellIdentifier: "weatherCellIdentifier", items: weatherListViewModel.weatherViewModels){ cell, vm in
            cell.cityNameLabel.text = vm.name.value
            cell.temperatureLabel.text = vm.temperature.temperature.value.formatDegree
        }
        self.tableView.dataSource = dataSource
    }
    
    func addWeatherDidSave(vm: WeatherViewModel) {
        self.weatherListViewModel.AddWeatherViewModel(vm)
        self.dataSource.updateItems(items:self.weatherListViewModel.weatherViewModels)
        tableView.reloadData()
    }
    
    func SettingsDone(vm: SettingsViewModel) {
        weatherListViewModel.updateUnit(to: vm.selectedUnit)
        self.tableView.reloadData()
    }
    
  
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "AddWeatherSegueId"){
            guard let navVC = segue.destination as? UINavigationController else{
                fatalError("Navigation View Controller not found")
            }
            
            guard let addWeatherVC = navVC.viewControllers.first as? AddWeatherCityViewController else {
                fatalError("AddWeatherController not found")
            }
            
            addWeatherVC.delegate = self
            
        }else if segue.identifier == "SettingsSegueId"  {
            
            guard let navVC = segue.destination as? UINavigationController else{
                fatalError("Navigation View Controller not found")
            }
            
            guard let settingsVC = navVC.viewControllers.first as? SettingsViewController else {
                fatalError("SettingsController not found")
            }
            
            settingsVC.delegate = self
            
        } else if segue.identifier == "WeatherDetailsSegueId" {
            
            guard let vc = segue.destination as? WeatherDetailsViewController,
                let idexPath = tableView.indexPathForSelectedRow  else{
                return
            }
            
            let vm = weatherListViewModel.viewModel(atIndex: idexPath.row)
            vc.weatherViewModel = vm
            
            
        }
        
        
    }

    
}
