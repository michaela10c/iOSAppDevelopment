//
//  SimulationViewController.swift
//  Assignment4
//
//  Created by Michael Zhou on 7/14/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate{
    
    @IBOutlet weak var gridView: GridView!
    var engineProtocolObj: EngineProtocol!
    //let gridClass = Grid(rows: StandardEngine.sharedGridSize.grid.rows, cols: StandardEngine.sharedGridSize.grid.cols)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engineProtocolObj = StandardEngine.sharedGridSize
        engineProtocolObj.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(changeRows), name: "Rows", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(changeCols), name: "Cols", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func changeRows(){
        gridView.rows = StandardEngine.sharedGridSize.rows
    }
    
    func changeCols(){
        gridView.cols = StandardEngine.sharedGridSize.cols
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        gridView.grid = withGrid
    }
    
    @objc func stepIt(){
        StandardEngine.sharedGridSize.step()
    }
    
}
