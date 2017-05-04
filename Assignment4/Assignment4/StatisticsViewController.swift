//
//  StatisticsViewController.swift
//  Assignment4
//
//  Created by Douglas Newman on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    var alive: [GridPosition] {
        return lazyPositions(StandardEngine.engine.grid.size).filter { return  StandardEngine.engine.grid[$0.row, $0.col] == .alive }
    }

    var born: [GridPosition] {
        return lazyPositions(StandardEngine.engine.grid.size).filter { return  StandardEngine.engine.grid[$0.row, $0.col] == .born }
    }

    var died: [GridPosition] {
        return lazyPositions(StandardEngine.engine.grid.size).filter { return  StandardEngine.engine.grid[$0.row, $0.col] == .died }
    }

    var empty: [GridPosition] {
        return lazyPositions(StandardEngine.engine.grid.size).filter { return  StandardEngine.engine.grid[$0.row, $0.col] == .empty }
    }

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
        aliveCount.text = String(alive.count)
        bornCount.text = String(born.count)
        diedCount.text = String(died.count)
        emptyCount.text = String(empty.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
