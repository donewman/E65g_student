//
//  StatisticsViewController.swift
//  FinalProject
//
//  Created by Douglas Newman on 5/1/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var aliveCount: UILabel!
    
    @IBOutlet weak var bornCount: UILabel!
    
    @IBOutlet weak var diedCount: UILabel!
    
    @IBOutlet weak var emptyCount: UILabel!
    
    var nowAlive: [GridPosition] {
        return lazyPositions(StandardEngine.engine.grid.size).filter { return  StandardEngine.engine.grid[$0.row, $0.col] == .alive }
    }
    
    var nowBorn: [GridPosition] {
        return lazyPositions(StandardEngine.engine.grid.size).filter { return  StandardEngine.engine.grid[$0.row, $0.col] == .born }
    }
    
    var nowDied: [GridPosition] {
        return lazyPositions(StandardEngine.engine.grid.size).filter { return  StandardEngine.engine.grid[$0.row, $0.col] == .died }
    }
    
    var nowEmpty: [GridPosition] {
        return lazyPositions(StandardEngine.engine.grid.size).filter { return  StandardEngine.engine.grid[$0.row, $0.col] == .empty }
    }
    
    var alive: Int = 0
    var born: Int = 0
    var died: Int = 0
    var empty: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateCounts()
        let nc = NotificationCenter.default
        let update = Notification.Name(rawValue: "EngineUpdate")
        let reset = Notification.Name(rawValue: "EngineReset")
        nc.addObserver(forName: update, object: nil, queue: nil) {
            _ in self.updateCounts()
        }
        nc.addObserver(forName: reset, object: nil, queue: nil) {
            _ in self.resetCounts()
        }
    }
    
    func updateCounts() {
        alive += nowAlive.count
        born += nowBorn.count
        died += nowDied.count
        empty += nowEmpty.count
        updateText()
    }
    
    func resetCounts() {
        alive = 0
        born = 0
        died = 0
        empty = 0
        updateText()
    }
    
    func updateText() {
        aliveCount.text = String(alive)
        bornCount.text = String(born)
        diedCount.text = String(died)
        emptyCount.text = String(empty)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
