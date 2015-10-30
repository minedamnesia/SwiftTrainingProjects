//
//  ViewController.swift
//  WhereAmI
//
//  Created by Kelly Yamamoto on 10/30/15.
//  Copyright © 2015 Kelly Yamamoto. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate  {
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
        }()
    
    @IBOutlet var worldView: MKMapView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var locationTitleField: UITextField!
    
    func zoomMapToCoordinate(coord: CLLocationCoordinate2D, animated: Bool) {
        let region = MKCoordinateRegionMakeWithDistance(coord, 250, 250)
        worldView.setRegion(region, animated: animated)
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        let coord = userLocation.coordinate
        zoomMapToCoordinate(coord, animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        findLocation()
        
        return true
    }
    
    func findLocation() {
        locationManager.requestLocation()
        spinner.startAnimating()
        locationTitleField.hidden = true
    }
    
    func foundLocation(location: CLLocation) {
        let coord = location.coordinate
        
        let mapPoint = MapPoint(coordinate: coord, title: locationTitleField.text ?? "")
        worldView.addAnnotation(mapPoint)
        zoomMapToCoordinate(coord, animated: true)
        
        locationTitleField.text = ""
        locationTitleField.hidden = false
        spinner.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .Denied && authorizationStatus != .Restricted {
            print("Requesting location authorization.")
            locationManager.requestWhenInUseAuthorization()
            
            worldView.showsUserLocation = true
        }
        else {
            print("Location information not available.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

