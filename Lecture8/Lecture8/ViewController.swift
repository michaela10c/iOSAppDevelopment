//
//  FirstViewController.swift
//  Lecture8
//
//  Created by Michael Zhou on 7/18/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 4
    }

    override func tableView(tableView: UITableView, numberOfSections section: Int) -> Int{
        
    }
    
}

