//
//  CodableModel.swift
//  DataBaseHomeWork
//
//  Created by Влад Заборский on 25.04.2021.
//

import Foundation
import RealmSwift

struct Response: Codable {
    
    let current: Temp
    let daily: [DailyData]
}

struct Temp : Codable {
    
    let temp: Double
}

struct DailyData: Codable {
    
    var temp: DailyTemp
}

struct DailyTemp: Codable {
    
    var day: Double
}

extension Temp {
    var dayTemperature: String {
        let result = temp - 273.15
        return "\(Int(result))°C"
    }
}
