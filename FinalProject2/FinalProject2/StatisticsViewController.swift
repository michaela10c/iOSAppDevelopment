//
//  StatisticsViewController.swift
//  FinalProject2
//
//  Created by Michael Zhou on 8/3/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController, EngineDelegate {

    @IBOutlet weak var emptyTextField: UITextField!
    @IBOutlet weak var bornTextField: UITextField!
    @IBOutlet weak var livingTextField: UITextField!
    @IBOutlet weak var deadTextField: UITextField!
    
    let engine = StandardEngine.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        engine.delegate = self
        setupTextFields(StandardEngine.sharedInstance.grid)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func engineDidUpdate(withGrid: GridProtocol) {
        setupTextFields(withGrid)
    }
    
    func setupTextFields(grid: GridProtocol) {
        emptyTextField.text! = "\(engine.grid.empty)"
        bornTextField.text! = "\(engine.grid.born)"
        livingTextField.text! = "\(engine.grid.living)"
        deadTextField.text! = "\(engine.grid.died)"
    }



}
