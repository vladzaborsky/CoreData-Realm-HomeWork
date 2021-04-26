//
//  NetworkManager.swift
//  DataBaseHomeWork
//
//  Created by Влад Заборский on 25.04.2021.
//

import Foundation
import RealmSwift


class NetworkManager {
    
    func getData(_ urlString: String, _ complition: @escaping (Response) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let data = data {
                    let decoder = JSONDecoder()
                    let weather = try? decoder.decode(Response.self, from: data)
                    if let safeWeatherData = weather {
                        complition(safeWeatherData)
                    }
                }
            }
        }
        task.resume()
    }
}
