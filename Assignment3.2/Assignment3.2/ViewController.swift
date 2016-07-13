//
//  ViewController.swift
//  AssignmentThree
//
//  Created by Michael Zhou on 7/12/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit


enum CellState: String{
    case Living = "Living", Died = "Died", Born = "Born", Empty = "Empty"
    
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
    
    static func description(state: CellState)->String{
        return state.rawValue
    }
    
    func allValues() -> Array<String>{
        return [CellState.Born.rawValue, CellState.Living.rawValue, CellState.Empty.rawValue, CellState.Died.rawValue]
    }
    
    func toggle(value: CellState) -> CellState{
        switch value{
        case .Empty, .Died: return .Living
        case .Born, .Living: return .Empty
        }
    }
    
    
}

