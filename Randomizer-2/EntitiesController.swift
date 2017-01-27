//
//  EntitiesController.swift
//  Randomizer-2
//
//  Created by Evan Peterson on 1/27/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation

class EntitiesController {
    
    static let shared = EntitiesController()
    
    fileprivate static let kEntities = "entity"
    
    var entities: [Entities] = []
    
    init() {
        loadToPersistent()
        
    }
    
    func random() {
        entities.random()
        saveToPersistentStorage()
        
    }
    
    func add(entity: String) {
        let newEntity = Entities(person: entity)
        self.entities.append(newEntity)
        saveToPersistentStorage()
        
        
    }
    
    func saveToPersistentStorage() {
        let userDefaults = UserDefaults.standard
        let entitiesDict = entities.map({$0.dictionaryRep})
        
        userDefaults.set(entitiesDict, forKey: EntitiesController.kEntities)
    }
    
    func loadToPersistent() {
        let userDefaults = UserDefaults.standard
        
        guard let entitiesDict = userDefaults.object(forKey: EntitiesController.kEntities) as? [[String: String]] else { return }
        
        entities = entitiesDict.flatMap({Entities(dictionary: $0)})
        
    }
    
}

extension Array {
    mutating func random() {
        for _ in 0..<10 { sort { (_,_) in arc4random() < arc4random() } }
    }
}
