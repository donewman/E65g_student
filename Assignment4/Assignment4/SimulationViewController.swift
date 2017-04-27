//
//  SimulationViewController.swift
//  Assignment4
//
//  Created by Douglas Newman on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, GridViewDataSource, EngineDelegate {

    @IBOutlet weak var gridView: GridView!
    
    var engine: EngineProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let size = gridView.gridSize
        engine = StandardEngine(rows: size, cols: size)
        engine.delegate = self
        gridView.gridDataSource = self
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        nc.addObserver(forName: name, object: nil, queue: nil) {
            (n) in self.gridView.setNeedsDisplay()
        }
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        self.gridView.setNeedsDisplay()
    }
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return engine.grid[row,col] }
        set { engine.grid[row,col] = newValue }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        _ = engine.step()
    }
}
