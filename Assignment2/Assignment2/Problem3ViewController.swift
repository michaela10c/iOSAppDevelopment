//
//  Problem3ViewController.swift
//  Assignment2
//
//  Created by Michael Zhou on 2016/6/30.
//  Copyright © 2016年 Michael Zhou. All rights reserved.
//

import UIKit

class Problem3ViewController: UIViewController {

    @IBOutlet weak var textView3: UITextView!
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
        textView3.text = "Alive: \(a)\nDead: \(d)"
        step(cells)
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
