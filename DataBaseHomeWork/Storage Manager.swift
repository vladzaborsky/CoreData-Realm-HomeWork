//
//  Storage Manager.swift
//  DataBaseHomeWork
//
//  Created by Влад Заборский on 23.04.2021.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager {
        
    static func saveTask(_ task: Task) {
        
        try! realm.write {
            realm.add(task)
        }
    }
    
    static func deleteTask(_ task: Task) {
        
        try! realm.write {
            realm.delete(task)
        }
    }
    
}
