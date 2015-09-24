//
//  ObjectExtension.swift
//  RealmJsonMapper
//
//  Created by Eike Bartels on 06/09/15.
//  Copyright © 2015 Eike Bartels. All rights reserved.
//

import RealmSwift


extension Object{
    
    /**
    Provide an array of objects to convert. Example [[key in json : key in model]]
    
    :param: nil
    
    :returns: An array of key value Objects [[key in json : key in model]]
    */
    public class func mappingDictionary() -> [String : String]{
        return [:]
    }
    
    public convenience init(jsonObject: AnyObject){
        
        RealmJsonMapper.convert(jsonObject, realmClass: self.dynamicType)
        
        for property in self.dynamicType.sharedSchema().properties{
            print(property.name)
            let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
            if let className = property.objectClassName{
                if className.characters.count > 0 {
                    if let subClass = NSClassFromString("\(appName).\(className)"){
                        print(subClass.mappingDictionary?())
                        
                        
                    }
                }
            }
        }
        self.init(value: RealmJsonMapper.convert(jsonObject, mappingDictionary: self.dynamicType.mappingDictionary()))
    }

    

    
    
    
    public class func create(jsonObject: AnyObject) -> Object{
        return Object(jsonObject: jsonObject)
    }

    
    /**
    WARNING: swift 2.0 Bug with Type issue in Generic
    
    :param: jsonArry JSON Object Array
    
    :returns: An array of given Objects
    */
    public class func createfromArray(jsonArry: [AnyObject]) -> [Object]{
        var result:[Object] = []
        for jsonObject in jsonArry {
            result.append(Object(jsonObject: jsonObject))
        }
        return result
    }
}
