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
    
    
    var e = StandardEngine.sharedUpdates

    override func viewDidLoad() {
        super.viewDidLoad()
        rowText.text = e.rows.description
        colText.text = e.cols.description
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRowChanged(sender: AnyObject) {
        rowStepper = sender as! UIStepper
        e.rows = Int(rowStepper.value)
        rowText.text = rowStepper.value.description
         print("\(e.rows)")
    }

    @IBAction func onColChanged(sender: AnyObject) {
        colStepper = sender as! UIStepper
        e.cols = Int(colStepper.value)
        colText.text = colStepper.value.description
        print("\(e.cols)")
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
