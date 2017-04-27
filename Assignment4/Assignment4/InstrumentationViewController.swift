//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Douglas Newman on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController, UITextFieldDelegate {
    
    var engine: EngineProtocol!

    @IBOutlet weak var gridSizeTextField: UITextField!
    
    @IBOutlet weak var gridSizeStepper: UIStepper!
    
    @IBOutlet weak var refreshRateSlider: UISlider!
    
    @IBOutlet weak var refreshTimerSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func gridSizeTextFieldUpdate(_ sender: UITextField) {
        
    }
    
    @IBAction func gridSizeStepperUpdate(_ sender: UIStepper) {
        engine = StandardEngine(rows: Int(sender.value), cols: Int(sender.value))
        _ = engine.step()
        gridSizeTextField.text = "\(engine.rows)"
    }
    
    @IBAction func refreshRateSliderUpdate(_ sender: UISlider) {
        
    }
    
    @IBAction func refreshTimerSwitchToggle(_ sender: UISwitch) {
        
    }
    
}
