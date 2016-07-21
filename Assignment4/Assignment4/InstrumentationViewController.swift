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
    
    
    let gridClass = Grid(rows: StandardEngine.sharedGridSize.grid.rows, cols: StandardEngine.sharedGridSize.grid.cols)
    let notificationName = "Update!"//name of delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(update), name: "Rows", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(update), name: "Columns", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func RowChange(sender: AnyObject) {//tap for row change
        rowStepper = sender as! UIStepper//my stepper
        //StandardEngine.sharedGridSize.rows = "\(rowStepper.value)"
        NSNotificationCenter.defaultCenter().postNotificationName("Rows", object: nil, userInfo: ["Rows": StandardEngine.sharedGridSize.rows])
        print("\(StandardEngine.sharedGridSize.rows),\(StandardEngine.sharedGridSize.cols)")
        rowText.text = "\(rowStepper.value)"
    }
    
    @IBAction func colChange(sender: AnyObject) {//tap for column change
        colStepper = sender as! UIStepper//my stepper
        //gridClass.cols = Int(colStepper.value)
        //text
        NSNotificationCenter.defaultCenter().postNotificationName("Columns", object: nil, userInfo: ["Columns": gridClass.cols])
        print("\(gridClass.rows),\(gridClass.cols)")
        colText.text = "\(StandardEngine.sharedGridSize.cols)"
        //post it
    }
    
    @IBAction func changeRefreshRate(sender: AnyObject) {
       // StandardEngine.sharedGridSize.refreshRate = sender.value
        refreshRateText.text = "\(StandardEngine.sharedGridSize.refreshRate)"
        // NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "ChangeGrid", object: StandardEngine.sharedGridSize.refreshRate, userInfo: ["Rate": StandardEngine.sharedGridSize.refreshRate]))
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
    
    func update(){//update me
       // grid.grid = Array(count: grid.rows, repeatedValue: Array(count: grid.cols, repeatedValue: CellState.Empty))
        
    }
}
