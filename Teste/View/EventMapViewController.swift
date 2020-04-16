//
//  EventMapViewController.swift
//  Teste
//
//  Created by Max Mendes on 16/04/20.
//  Copyright © 2020 Max Mendes. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class EventMapViewController: UIViewController{
    @IBOutlet weak var mapView: MKMapView!
    
    var latitude: Double?
    var longitude: Double?
    var eventName: String?
    
    override func viewDidLoad() {
        setEventMarker()
    }
    
    func setEventMarker(){
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        annotation.title = eventName
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
    }
}
