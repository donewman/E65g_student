//
//  InstrumentationViewController.swift
//  FinalProject
//
//  Created by Douglas Newman on 5/1/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var data: Array<Dictionary<String, Any>> = []
    
    let finalProjectURL = "https://dl.dropboxusercontent.com/u/7544475/S65g.json"
    
    @IBOutlet weak var configurationTableView: UITableView!
    
    @IBOutlet weak var sizeTextField: UITextField!
    
    @IBOutlet weak var sizeStepper: UIStepper!
    
    @IBOutlet weak var refreshRateSlider: UISlider!
    
    @IBOutlet weak var refreshTimerSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        sizeTextField.text = "\(StandardEngine.engine.rows)"
        sizeStepper.value = Double(StandardEngine.engine.rows)
        refreshRateSlider.value = Float(StandardEngine.engine.refreshRate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetch() {
        let fetcher = Fetcher()
        fetcher.fetchJSON(url: URL(string:finalProjectURL)!) { (json: Any?, message: String?) in
            guard message == nil else {
                print(message ?? "nil")
                return
            }
            guard let json = json else {
                print("no json")
                return
            }
            self.data = json as! Array
            OperationQueue.main.addOperation {
                self.configurationTableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in configurationTableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ configurationTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ configurationTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = configurationTableView.dequeueReusableCell(withIdentifier: "configurationTableViewCell", for: indexPath)
        cell.textLabel!.text = data[indexPath.item]["title"] as? String
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = configurationTableView.indexPathForSelectedRow
        if let indexPath = indexPath {
            let gridName = data[indexPath.row]["title"] as! String
            let gridArray = data[indexPath.row]["contents"] as! [[Int]]
            if let vc = segue.destination as? GridEditorViewController {
                vc.gridName = gridName
                vc.gridArray = gridArray
            }
        }
    }
    
    @IBAction func addRow(_ sender: Any) {
        
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
