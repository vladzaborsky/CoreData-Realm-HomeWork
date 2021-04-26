//
//  Persistence.swift
//  DataBaseHomeWork
//
//  Created by Влад Заборский on 23.04.2021.
//

import Foundation

class Persistence {
    
    static let shared = Persistence()
    
    private let kUserNameKey = "Persistence.kUserNameKey"
    private let kUserSurnameKey = "Persistence.kUserSurnameKey"
    
    var userName: String? {
        
        set { UserDefaults.standard.setValue(newValue, forKey: kUserNameKey)}
        get { return UserDefaults.standard.string(forKey: kUserNameKey)}
        
    }
    
    var userSurname: String? {
        
        set { UserDefaults.standard.setValue(newValue, forKey: kUserSurnameKey) }
        get { UserDefaults.standard.string(forKey: kUserSurnameKey) }
    }
    
    
}
