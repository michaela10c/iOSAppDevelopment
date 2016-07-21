//
//  ViewController.swift
//  sectionNotification
//
//  Created by Michael Zhou on 7/21/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let toPassToObservers : MyProtocol = MyClass()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(gotNotification), name: "MyNotification", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("MyNotification", object: nil, userInfo: ["ObjectToPass" : toPassToObservers])
        
        AppDelegate.MyProtocolSingleton.myField = 1
        
    }

    func gotNotification(notification: NSNotification){
        if let obj = notification.userInfo!["ObjectToPass"]{
            let myProtocol = obj as! MyProtocol
            print(myProtocol.myField)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

