//
//  DataStroageManager.swift
//  WisdomleafMovieApp
//
//  Created by Ankur Kumar on 30/08/24.
//

import Foundation


final class DataStorageManager {
    static let shared = DataStorageManager()
    private var dataSource = UserDefaults.standard
    
    func addToList(_ id: String) {
        dataSource.setValue(true, forKey: id)
        UserDefaults.standard.synchronize()
    }
    
    func removeFromList(_ id: String) {
        dataSource.setValue(nil, forKey: id)
        dataSource.synchronize()
    }
    
    func isAddedToList(_ id: String) -> Bool {
        if let value = dataSource.value(forKey: id) as? Bool, value {
            return value
        }
        return false
    }
}
