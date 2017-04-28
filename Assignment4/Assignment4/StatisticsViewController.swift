//
//  StatisticsViewController.swift
//  Assignment4
//
//  Created by Douglas Newman on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var bornCount: UILabel!
    
    @IBOutlet weak var livingCount: UILabel!
    
    @IBOutlet weak var diedCount: UILabel!
    
    @IBOutlet weak var emptyCount: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
