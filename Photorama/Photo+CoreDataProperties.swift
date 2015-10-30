//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by Kelly Yamamoto on 10/30/15.
//  Copyright © 2015 Kelly Yamamoto. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Photo {

    @NSManaged var photoID: String?
    @NSManaged var photoKey: String?
    @NSManaged var title: String?
    @NSManaged var dateTaken: NSDate?
    @NSManaged var remoteURL: NSObject?

}