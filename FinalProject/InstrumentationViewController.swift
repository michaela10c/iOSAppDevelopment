//
//  InstrumentationViewController.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/23/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {
    @IBOutlet weak var rowText: UITextField!
    @IBOutlet weak var colText: UITextField!
    @IBOutlet weak var rowStepper: UIStepper!
    @IBOutlet weak var colStepper: UIStepper!
    @IBOutlet weak var refreshRateText: UITextField!
    @IBOutlet weak var onOffSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        rowText.text =  StandardEngine.sharedUpdates.rows.description
        colText.text =  StandardEngine.sharedUpdates.cols.description
        refreshRateText.text = StandardEngine.sharedUpdates.refreshRate.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rowStepperChanged(sender: UIStepper) {
        let numRows = Int(sender.value)
        rowText.text = "\(numRows)"
        StandardEngine.sharedUpdates.rows = Int(rowText.text!)!
    }
    
    @IBAction func colStepperChanged(sender: UIStepper) {
        let numCols = Int(sender.value)
        colText.text = "\(numCols)"
        StandardEngine.sharedUpdates.cols = Int(colText.text!)!
    }
    
    @IBAction func onRefreshRateChanged(sender: UISlider) {
        if onOffSwitch.on{
        let rate = Double(sender.value)
        refreshRateText.text = "\(rate)"
        StandardEngine.sharedUpdates.refreshRate = rate
        }
        else{
            StandardEngine.sharedUpdates.stopTimer()
        }
    }
    
    @IBAction func startStopTimer(sender: AnyObject) {
        if onOffSwitch.on{
             StandardEngine.sharedUpdates.startTimer()
        } else{
            StandardEngine.sharedUpdates.stopTimer()
        }
        
    }

}

extension InstrumentationViewController: UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
