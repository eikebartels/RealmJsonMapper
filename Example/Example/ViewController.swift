//
//  ViewController.swift
//  Example
//
//  Created by Eike Bartels on 06/09/15.
//  Copyright (c) 2015 Eike Bartels. All rights reserved.
//

import UIKit
import RealmSwift
import RealmJsonMapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try NSFileManager.defaultManager().removeItemAtPath(Realm.Configuration.defaultConfiguration.path!)
        } catch {
            print("No Realm file exist")
        }
        
  
        //let theView:UIView = createdClass.init() // Should now give you a new object
        

        let path = NSBundle.mainBundle().pathForResource("Example_1", ofType: "json")!
        let jsonData = try! NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
        let jsonResult = try! NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
       

        print("============= Import JSON Objects =============")
        for jsonObject in jsonResult as! [[String : AnyObject]] {
            let product = Product(jsonObject: jsonObject)
            
//
//            print(Mirror(reflecting: product.tags))
//            print(Mirror(reflecting: product.id))
            
//            print("product", product)
        }
        
        
        
        
        
//        print("============= Import JSON Array =============")
//        let products = Product.createfromArray(jsonResult as! [AnyObject])
//        
//        print("products", products)
        
        


        
        
        

        
        
//        let product = Product()
//        product.id = 0
//        product.name = "bla"
//        
//        print(product)
//        
//        // Realms are used to group data together
        //let realm = try! Realm() // Create realm pointing to default file
        
//
//        // Save your object
//        realm.beginWrite()
//        realm.add(product)
//        realm.commitWrite()
//        
//        // Query
//        let results = realm.objects(Product) //.filter(NSPredicate(format:"name contains 'x'"))
//
//        print("query:  \(results)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

