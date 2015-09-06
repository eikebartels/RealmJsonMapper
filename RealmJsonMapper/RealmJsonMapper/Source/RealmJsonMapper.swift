//
//  RealmJsonMapper.swift
//  RealmJsonMapper
//
//  Created by Eike Bartels on 06/09/15.
//  Copyright © 2015 Eike Bartels. All rights reserved.
//


class RealmJsonMapper {
    
    static func convert(jsonObject: AnyObject, mappingDictionary:[String : String]) -> AnyObject{
        if var dic = jsonObject as? [String: AnyObject] {
            for map in mappingDictionary{
                if let val = RealmJsonMapper.value(dic, keyPath: map.0) as? [String : AnyObject] {
                    dic[map.1] = val
                    dic.removeValueForKey(map.0)
                }
            }
            return dic
        }
        return jsonObject
    }
    
    
    static func value(dic:[String: AnyObject], keyPath:String) -> AnyObject?{
        let keyArr = keyPath.componentsSeparatedByString(".")
        if keyArr.count > 1 {
            var childKeys = keyArr
            childKeys.removeAtIndex(0)
            return RealmJsonMapper.value(dic[keyArr.first!]! as! [String : AnyObject], keyPath: ".".join(childKeys))
        }
        return dic[keyArr.first!]
    }
}