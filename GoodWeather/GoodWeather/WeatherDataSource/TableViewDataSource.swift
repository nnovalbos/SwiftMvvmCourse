//
//  TableViewDataSource.swift
//  GoodWeather
//
//  Created by Nicolas Novalbos on 06/04/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<CellType, ViewModelType>: NSObject, UITableViewDataSource where CellType : UITableViewCell{
    
    let cellIdentifier: String
    var items: [ViewModelType]
    let configureCell : (CellType, ViewModelType) -> ()
    
     init(cellIdentifier: String, items: [ViewModelType], configureCell: @escaping (CellType, ViewModelType) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func updateItems(items: [ViewModelType]){
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CellType else {
            fatalError("Errror. Cell with identigier \(self.cellIdentifier) not found")
        }
        
        let vm = items[indexPath.row]
        self.configureCell(cell, vm)
        return cell
    }
    
    
}
