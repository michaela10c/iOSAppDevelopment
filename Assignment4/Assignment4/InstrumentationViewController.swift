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
    var grid = StandardEngine.sharedGridSize.grid
    // let gv = GridView()
    
    let notificationName = "Update!"//name of delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(update), name: notificationName, object: nil)//add me to observe the changes/receiver
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func RowChange(sender: AnyObject) {//tap for row change
        rowStepper = sender as! UIStepper//my stepper
        gridClass.rows = Int(rowStepper.value)//set
        rowText.text = "\(gridClass.rows)"//set my text to number of Rows
        
        NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: nil, userInfo: ["Rows": gridClass.rows])
        print("\(gridClass.rows),\(gridClass.cols)")
    }
    
    @IBAction func colChange(sender: AnyObject) {//tap for column change
        colStepper = sender as! UIStepper//my stepper
        gridClass.cols = Int(colStepper.value)
        //StandardEngine.sharedGridSize.cols = gridClass.cols//set cols to singleton cols
        colText.text = "\(gridClass.cols)"//text
        NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: nil, userInfo: ["Columns": gridClass.cols])
        print("\(gridClass.rows),\(gridClass.cols)")
        //post it
    }
    
    @IBAction func changeRefreshRate(sender: AnyObject) {
        StandardEngine.sharedGridSize.refreshRate = sender.value
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
        grid = Grid(rows: gridClass.rows, cols:gridClass.cols)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
