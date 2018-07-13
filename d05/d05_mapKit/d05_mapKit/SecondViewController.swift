//
//  SecondViewController.swift
//  d05_mapKit
//
//  Created by Remy SIBIET on 11/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    var annot = MKPointAnnotation()
    var myLocation = data.lieux[0].1
    
//       Geolocalisation
    var locationManager = CLLocationManager()
    
//       Action when value of segemented Control has changed
    @IBAction func ValueChanged(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        let qos = DispatchQoS.userInitiated.qosClass
        let queue = DispatchQueue.global(qos: qos)
        selectedLocation()
        queue.async {
            var i = data.index
            while (1 > 0) {
                usleep(300000)
                if data.index != i {
                    i = data.index
                    DispatchQueue.main.async {
                        self.selectedLocation()
                    }
                }
            }
        }
        
//        set data for localisation
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 5
        locationManager.startUpdatingLocation()
    }
    
    func selectedLocation() {
//        init map location
        let viewRegion = MKCoordinateRegionMakeWithDistance(data.lieux[data.index].1, 1000, 1000)
        mapView.setRegion(viewRegion, animated: false)
        for (lieu, l, descript) in data.lieux {
//        set annotation location and description when clic in on
            let annotation = MKPointAnnotation()
            annotation.coordinate = l
            annotation.title = lieu
            annotation.subtitle = descript
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var view: MKPinAnnotationView
        view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: 5)
        
        if annotation.title??.range(of:data.lieux[0].0) != nil {
            view.pinTintColor = UIColor.green
        }
        else if annotation.title??.range(of:data.lieux[1].0) != nil {
            view.pinTintColor = UIColor.blue
        }
        else if annotation.title??.range(of:data.lieux[2].0) != nil {
            view.pinTintColor = UIColor.purple
        }
        else {
            view.pinTintColor = UIColor.red
        }
        return view
    }

//        called methode every new localisation detected
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = manager.location {
            myLocation = CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
            annot.coordinate = myLocation
            mapView.addAnnotation(annot)
        }
    }

    @IBAction func yourPosition(_ sender: Any) {
        let viewRegion = MKCoordinateRegionMakeWithDistance(myLocation, 600, 600)
        mapView.setRegion(viewRegion, animated: true)
    }
    

}

