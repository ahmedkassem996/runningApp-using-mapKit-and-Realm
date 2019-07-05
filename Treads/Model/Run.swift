//
//  Run.swift
//  Treads
//
//  Created by AHMED on 1/30/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import Foundation
import RealmSwift

class Run: Object{
  
  @objc dynamic public private(set) var id = ""
  @objc dynamic public private(set) var date = NSDate()
  @objc dynamic public private(set) var pace = 0
  @objc dynamic public private(set) var distance = 0.0
  @objc dynamic public private(set) var duration = 0
  public private(set) var locations = List<Location>()
  
  override class func primaryKey() -> String{
    return "id"
  }

  override class func indexedProperties() -> [String] {
    return ["pace", "date", "duration"]
  }
  
  convenience init(pace: Int, distance: Double, duration: Int, locations: List<Location>){
    self.init()
    self.id = UUID().uuidString.lowercased()
    self.date = NSDate()
    self.pace = pace
    self.distance = distance
    self.duration = duration
    self.locations = locations
  }
  
  static func addRunToRealm(pace: Int, distance: Double, duration: Int, locations: List<Location>) {
    REALM_QUEUE.sync {
      let run = Run(pace: pace, distance: distance, duration: duration, locations: locations)
      do {
        let realm = try Realm(configuration: realmConfiguration.runDataConfig)
        try realm.write {
          realm.add(run)
          try realm.commitWrite()
        }
      } catch {
        debugPrint("Error adding run to realm!")
      }
    }
  }
  
  static func getAllRun() -> Results<Run>?{
    do{
      let realm = try Realm(configuration: realmConfiguration.runDataConfig)
      var runs = realm.objects(Run.self)
      runs = runs.sorted(byKeyPath: "date", ascending: false)
      return runs
    }catch{
      return nil
    }
  }
  
  static func getrun(byId id: String) -> Run?{
    do{
      let realm  = try Realm(configuration: realmConfiguration.runDataConfig)
      return realm.object(ofType: Run.self, forPrimaryKey: id)
    }catch{
      return nil
    }
  }
}
