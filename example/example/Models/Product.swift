//
//  ProductModel.swift
//  Example
//
//  Created by Eike Bartels on 24/09/15.
//  Copyright © 2015 Eike Bartels. All rights reserved.
//

import RealmSwift
import RealmJsonMapper


class Product: Object {
    
    dynamic var id:Int = 0
    dynamic var name:String = ""
    dynamic var price:Float = 0
    
    let tags = List<Tag>()
    
    override class func mappingDictionary() -> [String : String] {
        return ["productName" : "name",
                "prices.euro" : "price",
                "awesomeTags" : "tags"]
    }

}
