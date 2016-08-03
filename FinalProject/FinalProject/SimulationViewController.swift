//
//  SimulationViewController.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/23/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

//list of the main notifications to be sent - for the timer
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
        StandardEngine.sharedUpdates.checkConfigurations = false
        gridView.setNeedsDisplay()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshGrid), name: timerStepNotification, object: nil)
        
        print("\(StandardEngine.sharedUpdates.rows),\(StandardEngine.sharedUpdates.cols)")
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
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let add = UIAlertAction(title: "Add", style: .Default) { (action) in
            NSNotificationCenter.defaultCenter().postNotificationName("Add configuration", object: nil, userInfo: ["New Configuration": ""])
            print("\(StandardEngine.sharedUpdates.configuration?.title)")
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
        //send a notification to the timerSwitch to change it's physical state (turn it off)
    }

}

extension SimulationViewController: UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //Allow selection for the user
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.selectedTextRange = textField.textRangeFromPosition(textField.beginningOfDocument, toPosition: textField.endOfDocument)
    }
}
