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
    
    var gridDataSource: GridViewDataSource?
    var gridName: String = ""
    var gridArray: [[Int]] = []
    var engine = StandardEngine(rows: 10, cols: 10)
    var newGridArray: [[Int]]?
    var saveName: ((String) -> Void)?
    var saveGrid: (([[Int]]) -> Void)?
    
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
        if (gridArray.count > 0 && gridArray[0] != [0]) {
            loadGrid()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return engine.grid[row,col] }
        set { engine.grid[row,col] = newValue }
    }
    
    func loadGrid() {
        (0 ..< gridArray.count).forEach { n in
            engine.grid[(gridArray[n][0]),(gridArray[n][1])] = .alive
        }
    }
    
    func getNewGridArray() {
        newGridArray = []
        lazyPositions(engine.grid.size).forEach {
            switch self[$0.row, $0.col] {
            case .alive:
                newGridArray! += [[$0.row, $0.col]]
            default:
                ()
            }
        }
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        StandardEngine.engine.grid = engine.grid
        StandardEngine.engine.rows = editorGridView.gridSize
        StandardEngine.engine.cols = editorGridView.gridSize
        let nc = NotificationCenter.default
        let update = Notification.Name(rawValue: "EngineUpdate")
        let n = Notification(name: update, object: nil, userInfo: ["engine" : StandardEngine.engine])
        nc.post(n)
        if let newName = gridNameTextField.text,
            let saveName = saveName {
            saveName(newName)
            self.navigationController?.popViewController(animated: true)
        }
        getNewGridArray()
        if let newArray = newGridArray,
            let saveGrid = saveGrid {
            saveGrid(newArray)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
