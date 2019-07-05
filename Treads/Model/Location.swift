//
//  Location.swift
//  Treads
//
//  Created by AHMED on 1/30/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object{
  @objc dynamic public private(set) var latitude = 0.0
  @objc dynamic public private(set) var longitude = 0.0
  
  convenience init(latitude: Double, longitude: Double){
    self.init()
    self.latitude = latitude
    self.longitude = longitude
  }
  
}

