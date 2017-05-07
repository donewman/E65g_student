//
//  GridEditorViewController.swift
//  FinalProject
//
//  Created by Douglas Newman on 5/2/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class GridEditorViewController: UIViewController {
    
    var gridName: String = ""
    var gridArray: [[Int]] = []
    var saveClosure: ((String) -> Void)?
    
    @IBOutlet weak var gridNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        gridNameTextField.text = gridName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
    }
    
}
