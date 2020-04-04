//
//  SettingsViewController.swift
//  GoodWeather
//
//  Created by Nicolas Novalbos on 03/04/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation
import UIKit



protocol SettingsDelegate {
    func SettingsDone(vm: SettingsViewModel)
}

class SettingsViewController: UITableViewController {
    
    private var settingsViewModel = SettingsViewModel()
    
    var delegate : SettingsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func Done() {
        
        if let deletage = delegate {
            delegate?.SettingsDone(vm: settingsViewModel)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellItem = settingsViewModel.units[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        cell.textLabel?.text = cellItem.displayName
        
        if(cellItem == settingsViewModel.selectedUnit){
            cell.accessoryType = .checkmark
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       

        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = .checkmark
            
            let unit = Unit.allCases[indexPath.row]
            settingsViewModel.selectedUnit = unit
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = .none
        }
    }
    
}
