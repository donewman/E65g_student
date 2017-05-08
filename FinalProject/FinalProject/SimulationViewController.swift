//
//  SimulationViewController.swift
//  FinalProject
//
//  Created by Douglas Newman on 5/1/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, GridViewDataSource, EngineDelegate {

    @IBOutlet weak var gridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StandardEngine.engine.delegate = self
        gridView.gridDataSource = self
        let nc = NotificationCenter.default
        let update = Notification.Name(rawValue: "EngineUpdate")
        nc.addObserver(forName: update, object: nil, queue: nil) {
            (n) in self.gridView.gridSize = StandardEngine.engine.rows
            self.gridView.setNeedsDisplay()
        }
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        self.gridView.setNeedsDisplay()
    }
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return StandardEngine.engine.grid[row,col] }
        set { StandardEngine.engine.grid[row,col] = newValue }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        _ = StandardEngine.engine.step()
    }
    
    @IBAction func resetButton(_ sender: Any) {
        StandardEngine.engine.grid = Grid(StandardEngine.engine.rows, StandardEngine.engine.cols)
        self.gridView.gridSize = StandardEngine.engine.rows
        self.gridView.setNeedsDisplay()
        let nc = NotificationCenter.default
        let reset = Notification.Name(rawValue: "EngineReset")
        let n = Notification(name: reset, object: nil, userInfo: ["engine" : StandardEngine.engine])
        nc.post(n)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        lazyPositions(StandardEngine.engine.grid.size).forEach {
            switch self[$0.row, $0.col] {
            case .born:
                configuration["born"] = (configuration["born"] ?? []) + [[$0.row, $0.col]]
            case .alive:
                configuration["alive"] = (configuration["alive"] ?? []) + [[$0.row, $0.col]]
            case .died:
                configuration["died"] = (configuration["died"] ?? []) + [[$0.row, $0.col]]
            case .empty:
                ()
            }
        }
    }
}
