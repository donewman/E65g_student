//
//  StatisticsViewController.swift
//  FinalProject
//
//  Created by Douglas Newman on 5/1/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    var cycles: Int = 0
    var aliveCells: Int = 0
    var bornCells: Int = 0
    var emptyCells: Int = 0
    var diedCells: Int = 0
    
    @IBOutlet weak var cyclesCount: UILabel!
    
    @IBOutlet weak var aliveCount: UILabel!
    
    @IBOutlet weak var bornCount: UILabel!
    
    @IBOutlet weak var diedCount: UILabel!
    
    @IBOutlet weak var emptyCount: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        nc.addObserver(forName: name, object: nil, queue: nil) {
            _ in self.updateCounts()
        }
    }
    
    func updateCounts() {
        cycles += 1
        cyclesCount.text = String(cycles)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
