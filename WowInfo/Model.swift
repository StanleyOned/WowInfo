//
//  Model.swift
//  WowInfo
//
//  Created by Stanley Delacruz on 1/25/18.
//  Copyright © 2018 Stanley Delacruz. All rights reserved.
//

import Foundation


struct Model: Decodable {
    
    let ranking: Int?
    let rating: Int?
    let realmName: String?
    let name: String?
    let classId: Int?
    let factionId: Int?
    let seasonWins: Int?
    let seasonLosses: Int?
    
    init(dictionary: [String: Any]) {
        
        ranking = dictionary["ranking"] as? Int
        rating = dictionary["rating"] as? Int
        realmName = dictionary["realmName"] as? String ?? "Unknown Realm"
        name = dictionary["name"] as? String? ?? "Unknown Name"
        classId = dictionary["classId"] as? Int
        factionId = dictionary["factionId"] as? Int
        seasonWins = dictionary["seasonWins"] as? Int
        seasonLosses = dictionary["seasonLosses"] as? Int
    }
}
