//
//  ConfigurationViewController.swift
//  FinalProject2
//
//  Created by Michael Zhou on 8/3/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class ConfigurationViewController: UITableViewController, EngineDelegate {
    let engine = StandardEngine.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engine.loadConfigurations()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        engine.configurationIndex = nil
        tableView.reloadData()
        engine.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func engineDidUpdate(withConfigurations: Array<Configuration>) {
        tableView.reloadData()
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        
    }

    @IBAction func addConfiguration(sender: AnyObject) {
        
    }

    @IBAction func reparseData(sender: AnyObject) {
        engine.loadConfigurations()
        tableView.reloadData()
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
