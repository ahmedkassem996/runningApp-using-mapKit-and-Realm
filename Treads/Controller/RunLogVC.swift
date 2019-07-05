//
//  RunLogVC.swift
//  Treads
//
//  Created by AHMED on 1/27/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class RunLogVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self

  }


}

extension RunLogVC: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Run.getAllRun()?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "RunLogCell") as? RunLogCell{
      guard let run = Run.getAllRun()?[indexPath.row] else{
        return RunLogCell()
      }
      cell.configure(run: run)
      return cell
    }else{
      return RunLogCell()
    }
  }
}
