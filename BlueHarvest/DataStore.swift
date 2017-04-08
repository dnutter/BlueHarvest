//
//  DataStore.swift
//  BlueHarvest
//
//  Created by David Nutter on 3/19/17.
//  Copyright © 2017 David Nutter. All rights reserved.
//

import Foundation

class DataStore {
    
    static let shared = DataStore()
    
    private static let profiles = "profiles"
    private let backgroundQueue = DispatchQueue(label: "com.dnutter.datastore")

    private static var filePath : String {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return url.appendingPathComponent(self.profiles).path
    }
    
    func archive(profiles: [Profile]) {
        
        let objects = profiles.map { $0.asDictionary() }
        self.backgroundQueue.async {
            if !NSKeyedArchiver.archiveRootObject(objects, toFile: DataStore.filePath) {
                print("Unable to archive profiles")
            }
        }
        
    }
    
    func unarchive() -> [Profile] {
        var objects = [Profile]()
        if let array = NSKeyedUnarchiver.unarchiveObject(withFile: DataStore.filePath) as? [[String: Any]] {
            objects = array.flatMap { Profile.init(with: $0) }
        }
        return objects
    }
}
