//
//  WeatherModelRealm.swift
//  DataBaseHomeWork
//
//  Created by Влад Заборский on 25.04.2021.
//

import Foundation
import RealmSwift

class DataSet: Object {
    
    @objc dynamic var temp: Double = 0
    var daily = List<Daily>()
}

class Daily: Object {
    @objc dynamic var day: Double = 0
}
