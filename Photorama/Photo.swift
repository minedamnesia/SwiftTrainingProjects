//
//  Photo.swift
//  Photorama
//
//  Created by Kelly Yamamoto on 10/30/15.
//  Copyright © 2015 Kelly Yamamoto. All rights reserved.
//

import UIKit
import CoreData

class Photo: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    var image: UIImage?
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        //give properties initial values
        title = ""
        photoID = ""
        remoteURL = NSURL()
        photoKey = NSUUID().UUIDString
        dateTaken = NSDate()
    }
    
    func addTagObject(tag: NSManagedObject) {
        let currentTags = mutableSetValueForKey("tags")
        currentTags.addObject(tag)
    }
    func removeTagObject(tag: NSManagedObject) {
        let currentTags = mutableSetValueForKey("tags")
        currentTags.removeObject(tag)
    }

}
