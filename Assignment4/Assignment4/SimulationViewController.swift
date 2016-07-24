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
            let myprotocol = obj as! EngineProtocol
            gridView.grid.rows = myprotocol.rows}
    }
    
    func changeCols(notification: NSNotification){
        if let obj = notification.userInfo!["Cols"]{
            let myprotocol = obj as! EngineProtocol
            gridView.grid.cols = myprotocol.cols}
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        gridView.grid.rows = StandardEngine.sharedGridSize.rows
        gridView.grid.cols = StandardEngine.sharedGridSize.cols
        gridView.grid = withGrid
        gridView.setNeedsDisplay()
    }
    
    @objc func stepIt(){
        StandardEngine.sharedGridSize.step()
    }
    
}
