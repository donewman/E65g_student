//
//  GridEditorViewController.swift
//  FinalProject
//
//  Created by Douglas Newman on 5/2/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class GridEditorViewController: UIViewController {
    
    @IBOutlet weak var editorGridView: GridView!
    
    @IBOutlet weak var gridNameTextField: UITextField!
    
    var gridName: String = ""
    var gridArray: [[Int]] = []
    var saveClosure: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gridArrayMax = (Array(gridArray.joined()).max()! * 2)
        if (gridArrayMax >= 10) {
            self.editorGridView.gridSize = gridArrayMax
        }
        else {
            self.editorGridView.gridSize = 10
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
    }
    
}
