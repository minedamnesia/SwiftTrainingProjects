//
//  MapPoint.swift
//  WhereAmI
//
//  Created by Kelly Yamamoto on 10/30/15.
//  Copyright © 2015 Kelly Yamamoto. All rights reserved.
//

import Foundation
import MapKit
class MapPoint: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?) {
        self.coordinate = coordinate
        self.title = title
        
        super.init()
    }
    
}
