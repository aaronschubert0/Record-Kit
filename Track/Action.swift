//
//  Action.swift
//  Track
//
//  Created by Aaron Schubert on 08/01/2016.
//  Copyright © 2016 aaronschubert. All rights reserved.
//

import Foundation

struct Action {
    var identifier: String
    var action: String
    var hasDelay: Bool
    
    init(identifier: String, action: String, delay: Bool) {
        self.identifier = identifier
        self.action = action
        self.hasDelay = delay
    }
    init(dictionary: [String : AnyObject]) {
        self.identifier = dictionary["identifier"] as! String
        self.action = dictionary["action"] as! String
        self.hasDelay = dictionary["delay"] as! NSNumber as Bool
    }
    
    func dictionaryRepresentation() -> [String : AnyObject] {
        return ["identifier":self.identifier,"action":self.action,"delay":NSNumber(bool: self.hasDelay)]
    }
    
}