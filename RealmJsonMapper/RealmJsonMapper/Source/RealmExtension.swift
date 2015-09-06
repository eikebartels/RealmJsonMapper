//
//  RealmExtension.swift
//  RealmJsonMapper
//
//  Created by Eike Bartels on 06/09/15.
//  Copyright © 2015 Eike Bartels. All rights reserved.
//

import RealmSwift

extension Realm{
    
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