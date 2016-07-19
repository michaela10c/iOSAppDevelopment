//
//  FirstViewController.swift
//  JpTest
//
//  Created by Michael Zhou on 7/18/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(seeNotification), name: "BobTest", object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // Helper Method
    func seeNotification(notification: NSNotification) {
        print ("Notification: <\(notification)> (\(notification.userInfo))")
    }
    
}