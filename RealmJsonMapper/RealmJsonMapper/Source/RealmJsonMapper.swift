//
//  RealmJsonMapper.swift
//  RealmJsonMapper
//
//  Created by Eike Bartels on 06/09/15.
//  Copyright © 2015 Eike Bartels. All rights reserved.
//

import RealmSwift

private struct ObjectRelation{
    let name:String
    let className:AnyClass
}

class RealmJsonMapper {
    
    private var result:AnyObject!
    private var realmClass:Object.Type!
    private var jsonObject:AnyObject!
    private var relations:[ObjectRelation] = []
    
    private init(jsonObject: AnyObject, realmClass:Object.Type){
        self.realmClass = realmClass
        self.jsonObject = jsonObject
        
        self.relations = self.parseRelations()

//        print(realmClass.sharedSchema())
        print(self.relations)
        print(self.convertJSON(jsonObject, mappingDictionary: realmClass.mappingDictionary()))
        
    
    }
    
    private func parseRelations() -> [ObjectRelation]{
        var rel:[ObjectRelation] = []
        for property in realmClass.sharedSchema().properties{
            let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
            if let className = property.objectClassName{
                if className.characters.count > 0 {
                    if let subClass = NSClassFromString("\(appName).\(className)"){
                        rel.append(ObjectRelation(name: property.name, className: subClass))
                    }
                }
            }
        }
        return rel
    }

    private func convertJSON(jsonObject: AnyObject, mappingDictionary:[String : String]) -> AnyObject{
        if var dic = jsonObject as? [String: AnyObject] {
            for map in mappingDictionary{
                if let val = RealmJsonMapper.value(dic, keyPath: map.0){
                    dic[map.1] = val
                    dic.removeValueForKey(map.0)
                }
                
                if self.isRelation(map.1) {
                    print(dic)
                    print("Yey.... parse Relation")
                }
                
            }
            return dic
        }
        return jsonObject
    }
    
    private func isRelation(key:String) -> Bool {
        return self.relations.filter({$0.name == key}).count > 0
    }
    
    static func convert(jsonObject: AnyObject, realmClass:Object.Type) -> AnyObject{
        let mapper = RealmJsonMapper(jsonObject: jsonObject, realmClass: realmClass)
        
        return mapper.result
    }
    
    static func convert(jsonObject: AnyObject, mappingDictionary:[String : String]) -> AnyObject{
        if var dic = jsonObject as? [String: AnyObject] {
            for map in mappingDictionary{
                if let val = RealmJsonMapper.value(dic, keyPath: map.0){
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
            if let subDic = dic[keyArr.first!] as? [String : AnyObject]{
                return RealmJsonMapper.value(subDic, keyPath: childKeys.joinWithSeparator("."))
            }
            return nil
        }
        return dic[keyArr.first!]
    }
}