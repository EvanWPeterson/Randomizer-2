//
//  EntitiesController.swift
//  Randomizer-2
//
//  Created by Evan Peterson on 1/27/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation
import GameKit

class EntitiesController {
    
    static let shared = EntitiesController()
    
    fileprivate static let kEntities = "entity"
    
    var entities: [Entities] = []
    
    var pairPeople: [[Entities]] {
        return random(people: entities)
    }
    
    init() {
        loadToPersistent()
        
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

func random(people: [Entities]) -> [[Entities]] {
    let randomGen = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: entities)
    let splitSize = 2
    let people = stride(from: 0, to: randomGen.count, by: splitSize).map {
        Array(people[$0..<min($0 + splitSize, people.count)])
    }
    return people
    }
}


