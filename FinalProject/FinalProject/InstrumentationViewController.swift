//
//  InstrumentationViewController.swift
//  FinalProject
//
//  Created by Douglas Newman on 5/1/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController, /* UITableViewDelegate, UITableViewDataSource, */ UITextFieldDelegate {
    
    @IBOutlet weak var configurationTableView: UITableView!
    
    @IBOutlet weak var sizeTextField: UITextField!
    
    @IBOutlet weak var sizeStepper: UIStepper!
    
    @IBOutlet weak var refreshRateSlider: UISlider!

    @IBOutlet weak var refreshTimerSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizeTextField.text = "\(StandardEngine.engine.rows)"
        sizeStepper.value = Double(StandardEngine.engine.rows)
        refreshRateSlider.value = Float(StandardEngine.engine.refreshRate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sizeTextFieldUpdate(_ sender: UITextField) {
        guard let text = sender.text else { return }
        guard let val = Int(text) else {
            showErrorAlert(withMessage: "Invalid value: \(text), please try again.") {
                sender.text = "\(StandardEngine.engine.rows)"
            }
            return
        }
        StandardEngine.engine.grid = Grid(val, val)
        StandardEngine.engine.rows = val
        StandardEngine.engine.cols = val
        _ = StandardEngine.engine.step()
        sizeStepper.value = Double(StandardEngine.engine.rows)
    }
    
    @IBAction func sizeStepperUpdate(_ sender: UIStepper) {
        let val = Int(sender.value)
        StandardEngine.engine.grid = Grid(val, val)
        StandardEngine.engine.rows = val
        StandardEngine.engine.cols = val
        _ = StandardEngine.engine.step()
        sizeTextField.text = "\(StandardEngine.engine.rows)"
    }
    
    @IBAction func refreshRateSliderUpdate(_ sender: UISlider) {
        if refreshTimerSwitch.isOn && (TimeInterval(sender.value) > 0.0 ){
            StandardEngine.engine.refreshRate = TimeInterval(1 / sender.value)
        }
        else {
            StandardEngine.engine.refreshRate = 0.0
        }
        _ = StandardEngine.engine.step()
    }
    
    @IBAction func refreshTimerSwitchToggle(_ sender: UISwitch) {
        if refreshTimerSwitch.isOn && (TimeInterval(refreshRateSlider.value) > 0.0) {
            StandardEngine.engine.refreshRate = TimeInterval(refreshRateSlider.value)
        }
        else {
            StandardEngine.engine.refreshRate = 0.0
        }
        _ = StandardEngine.engine.step()
    }
    
    func showErrorAlert(withMessage msg: String, action: (() -> Void)? ) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            _ in alert.dismiss(animated: true) {
            }
            OperationQueue.main.addOperation {
                action?()
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
