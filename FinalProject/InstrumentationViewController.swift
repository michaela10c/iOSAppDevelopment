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

    //var configurations : [GridConfiguration] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rowText.text =  StandardEngine.sharedUpdates.rows.description
        colText.text =  StandardEngine.sharedUpdates.cols.description
        refreshRateText.text = StandardEngine.sharedUpdates.refreshRate.description
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rowStepperChanged(sender: UIStepper) {
        let numRows = Int(sender.value)
        rowText.text = "\(numRows)"
        StandardEngine.sharedUpdates.rows = numRows
    }
    
    @IBAction func colStepperChanged(sender: UIStepper) {
        let numCols = Int(sender.value)
        colText.text = "\(numCols)"
        StandardEngine.sharedUpdates.cols = numCols
    }
    
    @IBAction func onRefreshRateChanged(sender: UISlider) {
        let rate = Double(sender.value)
        refreshRateText.text = "\(rate)"
        StandardEngine.sharedUpdates.refreshRate = rate
    }
    
    //Inspired and modified from Nathan Guerin's section
    func fetch(){
        let url = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")!
        let fetcher = Fetcher()
        fetcher.requestJSON(url) { (json, message) in
            if let json = json {
               //let correctType = json as! [AnyObject]
               // let parser = GridConfigurationParser(configurations: correctType)
               // self.configurations = parser.parse()!
            }
            
            
            let op = NSBlockOperation {
                //self.tableView.reloadData()
            }
            NSOperationQueue.mainQueue().addOperation(op)
        }
    }
    
    

}
