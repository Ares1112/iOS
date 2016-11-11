//
//  ViewController.swift
//  Map
//
//  Created by Użytkownik Gość on 27.10.2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    var myLocationManager:CLLocationManager!
    
    @IBAction func stopButtonAction(sender: AnyObject) {
        startButton.enabled = true
        stopButton.enabled = false
        mapView.showsUserLocation = false
        myLocationManager.stopUpdatingLocation()
    }
    @IBAction func startButtonAction(sender: AnyObject) {
        startButton.enabled = false
        stopButton.enabled = true
        myLocationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    @IBAction func clearButtonAction(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled())
        {
            myLocationManager = CLLocationManager()
            myLocationManager.delegate = self
            myLocationManager.requestWhenInUseAuthorization()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    let currentLocation = locations.last!.coordinate
    
    let currentLocationPin = MKPointAnnotation()
    currentLocationPin.coordinate = currentLocation
    mapView.addAnnotation(currentLocationPin)
    
    var spanDelta = 0.0
    if let speed = locations.last?.speed where speed > 0 {
        spanDelta = speed/7000
    }
    
    let locationArea = MKCoordinateRegion(center: currentLocation, span: MKCoordinateSpan(latitudeDelta: spanDelta, longitudeDelta: spanDelta))
    mapView.setRegion(locationArea, animated: true)
  
    }

}

