//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Douglas Newman on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var rowsTextField: UITextField!
    
    @IBOutlet weak var rowsStepper: UIStepper!
    
    @IBOutlet weak var colsTextField: UITextField!
    
    @IBOutlet weak var colsStepper: UIStepper!
    
    @IBOutlet weak var refreshRateSlider: UISlider!

    @IBOutlet weak var refreshTimerSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rowsTextField.text = "\(StandardEngine.engine.rows)"
        rowsStepper.value = Double(StandardEngine.engine.rows)
        colsTextField.text = "\(StandardEngine.engine.cols)"
        colsStepper.value = Double(StandardEngine.engine.cols)
        refreshRateSlider.value = Float(StandardEngine.engine.refreshRate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func rowsTextFieldUpdate(_ sender: UITextField) {
        guard let text = sender.text else { return }
        guard let val = Int(text) else {
            showErrorAlert(withMessage: "Invalid value: \(text), please try again.") {
                sender.text = "\(StandardEngine.engine.rows)"
            }
            return
        }
        StandardEngine.engine.rows = val
        _ = StandardEngine.engine.step()
        rowsStepper.value = Double(StandardEngine.engine.rows)
    }
    
    @IBAction func rowsStepperUpdate(_ sender: UIStepper) {
        StandardEngine.engine.rows = Int(sender.value)
        _ = StandardEngine.engine.step()
        rowsTextField.text = "\(StandardEngine.engine.rows)"
    }
    
    @IBAction func colsTextFieldUpdate(_ sender: UITextField) {
        guard let text = sender.text else { return }
        guard let val = Int(text) else {
            showErrorAlert(withMessage: "Invalid value: \(text), please try again.") {
                sender.text = "\(StandardEngine.engine.cols)"
            }
            return
        }
        StandardEngine.engine.cols = val
        _ = StandardEngine.engine.step()
        colsStepper.value = Double(StandardEngine.engine.cols)
    }
    
    @IBAction func colsStepperUpdate(_ sender: UIStepper) {
        StandardEngine.engine.cols = Int(sender.value)
        _ = StandardEngine.engine.step()
        colsTextField.text = "\(StandardEngine.engine.cols)"

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
