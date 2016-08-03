//
//  SecondViewController.swift
//  FinalProject2
//
//  Created by Michael Zhou on 8/2/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate {

    @IBOutlet weak var gridView: GridView!
    let engine = StandardEngine.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        engine.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func engineDidUpdate(withGrid: GridProtocol) {
        if let gridView = gridView{
            gridView.setNeedsDisplay()
        }
        //StandardEngine.sharedInstance.grid = withGrid
    }
    func engineDidUpdate(withConfigurations: Array<Configuration>) {
        //StandardEngine.sharedInstance.configurations = withConfigurations
    }
    
    @IBAction func stepGrid(sender: AnyObject) {
        engine.step()
    }

    @IBAction func resetGrid(sender: AnyObject) {
        engine.emptyGrid()
    }
    @IBAction func saveGridToConfigurations(sender: AnyObject) {
        
    }
}

