//
//  SimulationViewController.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/23/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit
let timerStepNotification = "GridStep"
let timerStopNotification = "StopStep"

class SimulationViewController: UIViewController, EngineDelegate {
    
    @IBOutlet weak var gridView: GridView!
    var rate = StandardEngine.sharedUpdates.refreshRate
    
    let editor = ConfigurationEditorViewController()
    @IBOutlet weak var configurationNameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        StandardEngine.sharedUpdates.configuration = nil
        StandardEngine.sharedUpdates.delegate = self
        gridView.setNeedsDisplay()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshGrid), name: timerStepNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
         NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func engineDidUpdate(withGrid: GridProtocol) {
        // draw new grid
        gridView.setNeedsDisplay()
    }

    @IBAction func nextStep(sender: AnyObject) {
       refreshGrid()
    }
    
    @objc func refreshGrid(){
        StandardEngine.sharedUpdates.step()
        gridView.setNeedsDisplay()
    }
    
    @IBAction func saveConfiguration(sender: AnyObject) {
        StandardEngine.sharedUpdates.stopTimer()
        let controller = UIAlertController(title: "New Configuration", message: "Save to configurations as \(configurationNameText.text)?", preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: {_ in
            StandardEngine.sharedUpdates.startTimer()
        })
        let add = UIAlertAction(title: "Add", style: .Default) { (action) in
            StandardEngine.sharedUpdates.startTimer()
            NSNotificationCenter.defaultCenter().postNotificationName("Add configuration", object: nil, userInfo: ["New Configuration": ""])
            StandardEngine.sharedUpdates.configuration?.title = self.configurationNameText.text!
            print("\(self.configurationNameText.text!)")
        }
        controller.addAction(cancel)
        controller.addAction(add)
       self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func resetGrid(sender: AnyObject) {
        StandardEngine.sharedUpdates.emptyGrid()
        gridView.setNeedsDisplay()
        print("\(StandardEngine.sharedUpdates.grid)")
        StandardEngine.sharedUpdates.stopTimer()
        NSNotificationCenter.defaultCenter().postNotificationName(timerStopNotification, object: nil, userInfo: ["Stop": StandardEngine.sharedUpdates.refreshRate])//send a notification to the timerSwitch to change it's physical state (turn it off)
    }
    
}

extension SimulationViewController: UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
