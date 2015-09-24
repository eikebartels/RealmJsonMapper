//
//  TagModel.swift
//  Example
//
//  Created by Eike Bartels on 24/09/15.
//  Copyright © 2015 Eike Bartels. All rights reserved.
//

import RealmSwift

class Tag: Object {
    
    dynamic var name:String = ""
    

    override class func mappingDictionary() -> [String : String] {
        return ["tagName" : "name"]
    }
    
}
