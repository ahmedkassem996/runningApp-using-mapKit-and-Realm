//
//  BeginRunVC.swift
//  Treads
//
//  Created by AHMED on 1/27/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class BeginRunVC: LocationVC {

  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var lastRunCloseBtn: UIButton!
  @IBOutlet weak var paceLbl: UILabel!
  @IBOutlet weak var distanceLbl: UILabel!
  @IBOutlet weak var durationLbl: UILabel!
  @IBOutlet weak var lastRunBG: UIView!
  @IBOutlet weak var lastRunStack: UIStackView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    checkLocationAuthStatus()
   
 }

  override func viewWillAppear(_ animated: Bool) {
    manager?.delegate = self
     mapView.delegate = self
    manager?.startUpdatingLocation()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    setUpMapView()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    manager?.stopUpdatingLocation()
  }
  
  func setUpMapView(){
    if let overlay = addLastRunToMap(){
      if mapView.overlays.count > 0{
        mapView.removeOverlays(mapView.overlays)
      }
      mapView.addOverlay(overlay)
      lastRunStack.isHidden = false
      lastRunBG.isHidden = false
      lastRunCloseBtn.isHidden = false
    }else{
      lastRunStack.isHidden = true
      lastRunBG.isHidden = true
      lastRunCloseBtn.isHidden = true
      centerMapOnUserLocation()
    }
  }
  
  func addLastRunToMap() -> MKPolyline?{
    guard let lastRun = Run.getAllRun()?.first else{return nil}
    paceLbl.text = lastRun.pace.formatTimeDurationToString()
    distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
    durationLbl.text = lastRun.duration.formatTimeDurationToString()
    
    var coordinate = [CLLocationCoordinate2D]()
    for location in lastRun.locations{
      coordinate.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
    }
    
    mapView.userTrackingMode = .none
    guard let locations = Run.getrun(byId: lastRun.id)?.locations else{return MKPolyline()}
    mapView.setRegion(centerMapOnPreviousRoute(locations: locations), animated: true)
    
    return MKPolyline(coordinates: coordinate, count: locations.count)
  }
  
  func centerMapOnUserLocation(){
    mapView.userTrackingMode = .follow
    let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
  func centerMapOnPreviousRoute(locations: List<Location>) -> MKCoordinateRegion{
    guard let initialLocation = locations.first else{return MKCoordinateRegion()}
    var minLatt = initialLocation.latitude
    var minLong = initialLocation.longitude
    var maxLatt = minLatt
    var maxLong = minLong
    
    for location in locations{
      minLatt = min(minLatt, location.latitude)
      minLong = min(minLong, location.longitude)
      maxLatt = max(maxLatt, location.latitude)
      maxLong = max(maxLong, location.longitude)
      
    }
    return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (minLatt + maxLatt) / 2, longitude: (minLong + maxLong) / 2), span: MKCoordinateSpan(latitudeDelta: (maxLatt - minLatt) * 1.4, longitudeDelta: (maxLong - minLong) * 1.4))
  }

  @IBAction func lastRunCloseBtnPressed(_ sender: Any) {
    lastRunStack.isHidden = true
    lastRunBG.isHidden = true
    lastRunCloseBtn.isHidden = true
    centerMapOnUserLocation()
  }
  
  @IBAction func locationCenterButton(_ sender: Any) {
    centerMapOnUserLocation()
  }
  
}

extension BeginRunVC: CLLocationManagerDelegate{
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse{
      checkLocationAuthStatus()
      mapView.showsUserLocation = true
      
    }
  }
  
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let polyLine = overlay as! MKPolyline
    let render = MKPolylineRenderer(polyline: polyLine)
    render.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    render.lineWidth = 4
    return render
  }
}
