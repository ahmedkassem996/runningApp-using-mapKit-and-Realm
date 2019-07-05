//
//  RunLogCell.swift
//  Treads
//
//  Created by AHMED on 1/30/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class RunLogCell: UITableViewCell {
  
  @IBOutlet weak var runDurationLbl: UILabel!
  @IBOutlet weak var totalDistanceLbl: UILabel!
  @IBOutlet weak var averagePaceLbl: UILabel!
  @IBOutlet weak var dateLbl: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

  func configure(run: Run){
    runDurationLbl.text = run.duration.formatTimeDurationToString()
    totalDistanceLbl.text = "\(run.distance.metersToMiles(places: 2)) mi"
    averagePaceLbl.text = run.pace.formatTimeDurationToString()
    dateLbl.text = run.date.getDateString()
    }
}


