//
//  Meal.swift
//  FoodTracking
//
//  Created by Zach Owens on 1/18/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    //mark: properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //Mark: Archiving Paths
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("meals")
    
    //Mark: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //mark: initialization
    
    init?(name: String, photo: UIImage?, rating: Int){
     
        //initialization should fail if there is no value
        guard !name.isEmpty || rating < 0 else {
            return nil
        }
        
        //rating must be between 0-5
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        //initialized store properties
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
    
    //NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        //name is required. If we cannont decode a name string, the init should fail
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else {
                os_log("Unable to decode the name of a Meal object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        //Because photo is optional property in Meal, use conditional cast
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        //must call designated initilizer
        self.init(name: name, photo: photo, rating: rating)
    }
}
