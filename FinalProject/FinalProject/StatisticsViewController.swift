//
//  StatisticsViewController.swift
//  Assignment4
//
//  Created by Douglas Newman on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    var gridDataSource: GridViewDataSource?
    var gridCols: Int = StandardEngine.engine.cols
    var gridRows: Int = StandardEngine.engine.rows
    var aliveCells: Int = 0
    var bornCells: Int = 0
    var emptyCells: Int = 0
    var diedCells: Int = 0
    
    @IBOutlet weak var aliveCount: UILabel!
    
    @IBOutlet weak var bornCount: UILabel!
    
    @IBOutlet weak var diedCount: UILabel!
    
    @IBOutlet weak var emptyCount: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        nc.addObserver(forName: name, object: nil, queue: nil) {
            _ in self.resetCounts()
            self.updateCounts()
        }
    }
    
    func resetCounts () {
        aliveCells = 0
        bornCells = 0
        emptyCells = 0
        diedCells = 0
    }
    
    func updateCounts() {
        (0 ..< gridCols).forEach { i in
            (0 ..< gridRows).forEach { j in
                if gridDataSource?[(i,j)] == .alive {
                    aliveCells += 1
                    aliveCount.text = String(aliveCells)
                } else if gridDataSource?[(i,j)] == .born {
                    bornCells += 1
                    bornCount.text = String(bornCells)
                } else if gridDataSource?[(i,j)] == .empty {
                    emptyCells += 1
                    emptyCount.text = String(emptyCells)
                } else if gridDataSource?[(i,j)] == .died {
                    diedCells += 1
                    diedCount.text = String(diedCells)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
