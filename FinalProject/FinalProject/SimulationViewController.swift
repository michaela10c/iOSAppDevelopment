//
//  SimulationViewController.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/23/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    
    @IBOutlet weak var gridView: GridView!
    var rate = StandardEngine.sharedUpdates.refreshRate
    let notification = "GridStep"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        StandardEngine.sharedUpdates.configuration = nil
        StandardEngine.sharedUpdates.delegate = self
        gridView.setNeedsDisplay()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshGrid), name: notification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
         NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func engineDidUpdate(withGrid: GridProtocol) {
        // draw new grid
        gridView.setNeedsDisplay()
    }

    @IBAction func nextStep(sender: AnyObject) {
        StandardEngine.sharedUpdates.step()
        gridView.setNeedsDisplay()
    }
    
    @objc func refreshGrid(){
        StandardEngine.sharedUpdates.step()
        gridView.setNeedsDisplay()
    }
    @IBAction func addNewConfiguration(sender: AnyObject) {
       let controller = UIAlertController(title: "New Configuration", message: "Type in configuration name", preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let add = UIAlertAction(title: "Add", style: .Default) { (action) in
            if let textField: UITextField = (controller.textFields?.first)! as UITextField{
                
            }
        }
        controller.addAction(cancel)
        controller.addAction(add)
        controller.addTextFieldWithConfigurationHandler ({(textField) -> Void in textField.placeholder = "Configuration name"})
        self.presentViewController(controller, animated: true, completion: nil)
    }
}
