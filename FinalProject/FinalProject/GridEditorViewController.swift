//
//  GridEditorViewController.swift
//  FinalProject
//
//  Created by Douglas Newman on 5/2/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class GridEditorViewController: UIViewController, GridViewDataSource {
    
    @IBOutlet weak var editorGridView: GridView!
    
    @IBOutlet weak var gridNameTextField: UITextField!
    
    var gridName: String = ""
    var gridArray: [[Int]] = []
    var engine = StandardEngine(rows: 10, cols: 10)
    var saveClosure: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gridNameTextField.text = gridName
        editorGridView.gridDataSource = self
        let gridArrayMax = (Array(gridArray.joined()).max()! * 2)
        if (gridArrayMax >= 10) {
            self.editorGridView.gridSize = gridArrayMax
            engine.grid = Grid(gridArrayMax, gridArrayMax)
        }
        else {
            self.editorGridView.gridSize = 10
            engine.grid = Grid(10, 10)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return engine.grid[row,col] }
        set { engine.grid[row,col] = newValue }
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        StandardEngine.engine.grid = engine.grid
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        let n = Notification(name: name, object: nil, userInfo: ["engine" : self])
        nc.post(n)
    }
    
}
