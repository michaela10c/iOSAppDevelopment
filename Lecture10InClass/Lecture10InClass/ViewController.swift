//
//  ViewController.swift
//  Lecture10InClass
//
//  Created by Michael Zhou on 7/25/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fetch(sender: AnyObject) {
        let url = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")
        let fetcher = Fetcher()
        fetcher.requestJSON(url!) {  (json, message) in
            let op = NSBlockOperation {
            if let json = json {
                self.textView.text = json.description
            }
            else if let message = message{
                self.textView.text = message
            } else {
                self.textView.text = "WTF?"
            }
            }
            NSOperationQueue.mainQueue().addOperation(op)
        }
    }

}

