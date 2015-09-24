//
//  RealmExtension.swift
//  RealmJsonMapper
//
//  Created by Eike Bartels on 06/09/15.
//  Copyright © 2015 Eike Bartels. All rights reserved.
//

import RealmSwift

extension Realm{
    
    /**
    Create an `Object` with the given jsonObject.
    
    Creates or updates an instance of this object and adds it to the `Realm` populating
    the object with the given value.
    
    When 'update' is 'true', the object must have a primary key. If no objects exist in
    the Realm instance with the same primary key value, the object is inserted. Otherwise,
    the existing object is updated with any changed values.
    
    :param: type The object type to create.
    :parm: parameter The json object used to populate the object. This is usually the return form the methods in `NSJSONSerialization`.
    :parm: update If true will try to update existing objects with the same primary key.
    :returns: The created object.
    */
    public func create<T: Object>(type: T.Type, jsonObject: AnyObject = [:], update: Bool = false) -> T{
        return self.create(type, value: RealmJsonMapper.convert(jsonObject, mappingDictionary: type.mappingDictionary()), update: update)
    }
    
    public func create<T: Object>(type: T.Type, jsonArry: [AnyObject] = [], update: Bool = false) -> [T] {
        var result:[T] = []
        for jsonObject in jsonArry {
            result.append(self.create(type, value: RealmJsonMapper.convert(jsonObject, mappingDictionary: type.mappingDictionary()), update: update))
        }
        return result
    }
    
}