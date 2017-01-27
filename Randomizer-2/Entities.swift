//
//  Entities.swift
//  Randomizer-2
//
//  Created by Evan Peterson on 1/27/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation

class Entities {
    
    fileprivate static let kPerson = "person"
    //    fileprivate static let kGroup = "group"
    
    var person: String
    
    //    group: String? = nil
    
    init(person: String) {
        self.person = person
        
    }
    
    init?(dictionary: [String:Any]) {
        guard let person = dictionary[Entities.kPerson] as? String else { return nil }
        
        self.person = person
    }
    
    var dictionaryRep: [String: String] {
        return [Entities.kPerson: person]
    }
}
