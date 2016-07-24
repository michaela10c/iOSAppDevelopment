//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Michael Zhou on 7/14/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit


class InstrumentationViewController: UIViewController {
    
    @IBOutlet weak var rowText: UITextField!
    @IBOutlet weak var rowStepper: UIStepper!
    @IBOutlet weak var colText: UITextField!
    @IBOutlet weak var colStepper: UIStepper!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var refreshRateText: UITextField!
    
   // var delegate = StandardEngine.sharedGridSize.delegate
    
    //let notificationName = "Update!"
    var newGrid = StandardEngine.sharedGridSize.grid
   // let SVC = SimulationViewController()
    let gv = GridView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(update), name: "Rows", object: nil)
       // NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(update), name: "Cols", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func RowChange(sender: AnyObject) {//tap for row change
        rowStepper = sender as! UIStepper//my stepper
        newGrid.rows = Int(rowStepper.value)
        print("\(newGrid.rows),\(newGrid.cols)")
        gv.grid = newGrid
        rowText.text = "\(rowStepper.value)"
    }
    
    @IBAction func colChange(sender: AnyObject) {//tap for column change
        colStepper = sender as! UIStepper//my stepper
        newGrid.cols = Int(colStepper.value)
        print("\(newGrid.rows),\(newGrid.cols)")
        gv.grid = newGrid
        colText.text = "\(colStepper.value)"
        
    }
    
    @IBAction func changeRefreshRate(sender: AnyObject) {
       // StandardEngine.sharedGridSize.refreshRate = sender.value
        refreshRateText.text = "\(StandardEngine.sharedGridSize.refreshRate)"
    }
    
    @IBAction func turnOnOrOff(sender: AnyObject) {
        let standEng = StandardEngine(rows: Int(rowText.text!)!, cols: Int(colText.text!)!)
        let timer = standEng.refreshTimer
        if !switchButton.on{
            timer?.invalidate()
        }   else{
            timer?.fire()
            //standEng.step()
        }
    }
}
