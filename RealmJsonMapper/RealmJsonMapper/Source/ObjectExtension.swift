//
//  ObjectExtension.swift
//  RealmJsonMapper
//
//  Created by Eike Bartels on 06/09/15.
//  Copyright © 2015 Eike Bartels. All rights reserved.
//

import RealmSwift

extension Object{
    
    internal class func  mappingDictionary() -> [String : String] {
        return [ : ]
    }
    
    convenience init(jsonObject: AnyObject){
        self.init(value: RealmJsonMapper.convert(jsonObject, mappingDictionary: self.dynamicType.mappingDictionary()))
    }
    
    class func create(jsonObject: AnyObject) -> Object{
        return Object(jsonObject: jsonObject)
    }

    class func createfromArray(jsonArry: [AnyObject]) -> [Object]{
        var result:[Object] = []
        for jsonObject in jsonArry {
            result.append(Object(jsonObject: jsonObject))
        }
        return result
    }
}
