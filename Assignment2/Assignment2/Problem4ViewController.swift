//
//  Problem4ViewController.swift
//  Assignment2
//
//  Created by Michael Zhou on 2016/6/30.
//  Copyright © 2016年 Michael Zhou. All rights reserved.
//

import UIKit

class Problem4ViewController: UIViewController {

    @IBOutlet weak var textView4: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortIt()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func printSomething(sender: AnyObject) {
        textView4.text = "Alive: \(a)\nDead: \(d)"
         step2(cells)
    }

}
