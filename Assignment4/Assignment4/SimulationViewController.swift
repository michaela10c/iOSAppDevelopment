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
    let gridClass = Grid(rows: StandardEngine.sharedGridSize.grid.rows, cols: StandardEngine.sharedGridSize.grid.cols)
    let gv = GridView()
    let IVC = InstrumentationViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engineProtocolObj = StandardEngine.sharedGridSize
        engineProtocolObj.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(changeRows), name: "Rows", object: nil)//set me as notification observer/receiver
       // NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(stepIt), name: "ChangeGrid", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func changeRows(){
        StandardEngine.sharedGridSize.rows = StandardEngine.sharedGridSize.grid.rows
    }
    
    func update(){
        StandardEngine.sharedGridSize.rows = 
        StandardEngine.sharedGridSize.cols
        print("I just updated")
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        print("Hello!")
    }
    
    @objc func stepIt(){
        StandardEngine.sharedGridSize.step()
    }
    

}
