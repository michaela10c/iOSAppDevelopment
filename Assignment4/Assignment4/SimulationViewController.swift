//
//  SimulationViewController.swift
//  Assignment4
//
//  Created by Michael Zhou on 7/14/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate{
    
    var engineProtocolObj: EngineProtocol!
    let gridClass = Grid(rows: StandardEngine.sharedGridSize.rows, cols: StandardEngine.sharedGridSize.cols)
    let gv = GridView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engineProtocolObj = StandardEngine.sharedGridSize
        engineProtocolObj.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(update), name: "Update!", object: nil)//set me as notification observer/receiver
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update(){
        print("I just updated")
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        StandardEngine.sharedGridSize.step()
        gv.rows = gridClass.rows
        gv.cols = gridClass.cols
    }
    

}
