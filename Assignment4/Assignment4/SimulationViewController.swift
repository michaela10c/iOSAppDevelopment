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
    let newGridView = GridView()
    var grid = StandardEngine.sharedGridSize.grid
    var rows: Int {
        get { return StandardEngine.sharedGridSize.rows }
        set {
            var engine = StandardEngine.sharedGridSize
            engine.rows = newValue
        }
    }
    var cols: Int{
        get { return StandardEngine.sharedGridSize.cols }
        set {
            var engine = StandardEngine.sharedGridSize
            engine.cols = newValue
        }
    }
    
    
    
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
    
    func changeRows(notification: NSNotification){
        if let obj = notification.userInfo!["Rows"]{
            _ = obj as! EngineProtocol
            //gridView.grid.rows = myprotocol.rows
    }
    }
    
    func changeCols(notification: NSNotification){
        if let obj = notification.userInfo!["Cols"]{
            _ = obj as! EngineProtocol
            //gridView.grid.cols = myprotocol.cols
        }
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        //gridView.grid.rows = StandardEngine.sharedGridSize.rows
        //gridView.grid.cols = StandardEngine.sharedGridSize.cols
        gridView.grid = withGrid
        gridView.setNeedsDisplay()
    }
    
    func stepIt(){
        StandardEngine.sharedGridSize.step()
    }
    
    @IBAction func change(sender: AnyObject) {
        print("\(grid)")
        StandardEngine.sharedGridSize.step()
        //setNeedsDisplay()
    }

        
    
}
