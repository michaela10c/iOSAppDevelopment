//
//  SimulationViewController.swift
//  Assignment4
//
//  Created by Michael Zhou on 7/14/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController{
    
    var engineDelegate: EngineDelegate!
    var engineProtocolObj: EngineProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engineProtocolObj = StandardEngine.sharedGridSize
        engineProtocolObj.delegate = engineDelegate//should be self, but having trouble setting it
        engineDelegate = self
        //AppDelegate.EngineSingleton
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func stepTheDelegate(sender: AnyObject) {
        engineProtocolObj.step()
    }
}
