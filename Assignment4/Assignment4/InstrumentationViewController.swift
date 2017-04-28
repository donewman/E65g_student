//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Douglas Newman on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController, UITextFieldDelegate {
    
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
        let engine = StandardEngine.engine
        guard let text = sender.text else { return }
        guard let val = Int(text) else {
            showErrorAlert(withMessage: "Invalid value: \(text), please try again.") {
                sender.text = "\(engine.rows)"
            }
            return
        }
        engine.rows = val
        engine.cols = val
        _ = engine.step()
        gridSizeStepper.value = Double(engine.rows)
    }
    
    @IBAction func gridSizeStepperUpdate(_ sender: UIStepper) {
        let engine = StandardEngine.engine
        engine.rows = Int(sender.value)
        engine.cols = Int(sender.value)
        _ = engine.step()
        gridSizeTextField.text = "\(engine.rows)"
    }
    
    @IBAction func refreshRateSliderUpdate(_ sender: UISlider) {
        let engine = StandardEngine.engine
        if refreshTimerSwitch.isOn && (TimeInterval(sender.value) > 0.0 ){
            engine.refreshRate = TimeInterval(1 / sender.value)
        }
        else {
            engine.refreshRate = 0.0
        }
        _ = engine.step()
    }
    
    @IBAction func refreshTimerSwitchToggle(_ sender: UISwitch) {
        let engine = StandardEngine.engine
        if refreshTimerSwitch.isOn && (TimeInterval(refreshRateSlider.value) > 0.0) {
            engine.refreshRate = TimeInterval(refreshRateSlider.value)
        }
        else {
            engine.refreshRate = 0.0
        }
        _ = engine.step()
    }
    
    func showErrorAlert(withMessage msg:String, action: (() -> Void)? ) {
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
