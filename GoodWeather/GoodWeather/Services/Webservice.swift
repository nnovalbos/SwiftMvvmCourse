//
//  Webservice.swift
//  GoodWeather
//
//  Created by Nicolas Novalbos on 30/03/2020.
//  Copyright © 2020 Nicolas Novalbos. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class Webservice {
    
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()){
        
        URLSession.shared.dataTask(with: resource.url){ data, response, error in
            
            print(data)
            
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
