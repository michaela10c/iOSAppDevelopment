//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Michael Zhou on 7/14/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit


class InstrumentationViewController: UIViewController, EngineDelegate {

    @IBOutlet weak var rowText: UITextField!
    @IBOutlet weak var colText: UITextField!
    @IBOutlet weak var refreshRate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        let standEng = StandardEngine(rows: Int(rowText.text!)!, cols: Int(colText.text!)!)
        standEng.step()
    }
    
    @IBAction func RowChange(sender: AnyObject) {
        
    }
    
    @IBAction func colChange(sender: AnyObject) {
        
    }
    
    @IBAction func changeRefreshRate(sender: AnyObject) {
        
    }
    
    @IBAction func turnOnOrOff(sender: AnyObject) {
        
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
