//
//  ViewController.swift
//  Assignment3
//
//  Created by Michael Zhou on 7/6/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

enum CellState: String{
    case Living, Empty, Born, Died
    
    func allValues(){
        
    }
    
    func toggle(value: CellState) -> CellState{
        if value.rawValue == "Empty" || value.rawValue == "Died"{
            return .Living
        }
        else {
            return .Empty
        }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

