//
//  LocationVC.swift
//  Treads
//
//  Created by AHMED on 1/28/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, MKMapViewDelegate {
  
  var manager: CLLocationManager?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      manager = CLLocationManager()
      manager?.desiredAccuracy = kCLLocationAccuracyBest
      manager?.activityType = .fitness

    }
  
  func checkLocationAuthStatus(){
    if CLLocationManager.authorizationStatus() != .authorizedWhenInUse{
      manager?.requestWhenInUseAuthorization()
    }
  }
 
}
