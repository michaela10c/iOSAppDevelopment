//
//  ViewController.swift
//  Lecture6
//
//  Created by Michael Zhou on 7/11/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ExampleDelegateProtocol {
    
    var example: ExampleProtocol?
    @IBOutlet weak var rows: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        example = Example()
        example?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func implement(sender: AnyObject) {
        example?.rows += 10
    }
    
    func example(example: Example, didUpdateRows modelRows: UInt) {
        rows.text = "\(modelRows)"
        
    }
}

