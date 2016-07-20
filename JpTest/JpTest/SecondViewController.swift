//
//  SecondViewController.swift
//  JpTest
//
//  Created by Michael Zhou on 7/18/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    class InternalClass : TestDelegateProtocol {
        func delegateHasFired(isFired: Bool) {
            print("Delegate triggered: (\(isFired))")
        }
    }
    
    let delegate : TestDelegateProtocol = InternalClass()
    var toggle: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: UIButton) {
        delegate.delegateHasFired(toggle)
        NSNotificationCenter.defaultCenter().postNotificationName("BobTest", object: nil, userInfo: ["MyValue" : toggle])
        toggle = !toggle
    }
}

