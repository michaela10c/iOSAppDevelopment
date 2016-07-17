//
//  ViewController.swift
//  Tester
//
//  Created by Michael Zhou on 7/14/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hello! I'm a Title!"
        
        let result = divide(8, dividend: 9)
       
        // let isNotThree = (oneThroughThree != 3)
        if arc4random_uniform(3)==3{
            print("foo")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func divide(divisor: Int, dividend: Int) -> (Int,Int){
       var remainder = divisor
        var result = 0
        while divisor > 0{
            remainder -= dividend
            result += 1
        }
        return (result, remainder)
    }
}

