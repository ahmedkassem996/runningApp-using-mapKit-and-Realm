//
//  RealmConfiguration.swift
//  Treads
//
//  Created by AHMED on 1/31/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import Foundation
import RealmSwift


class realmConfiguration{
  static var runDataConfig: Realm.Configuration{
    let realmpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(REALM_RUN_CONFIG)
    let config = Realm.Configuration(
      fileURL: realmpath,
      schemaVersion: 0,
      migrationBlock:{migration,oldSchemaVersion in
        if(oldSchemaVersion < 0){
          
        }
    })
    return config
  }
}
