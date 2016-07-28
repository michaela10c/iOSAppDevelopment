//
//  StatisticsViewController.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/23/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController, EngineDelegate {
    
    @IBOutlet weak var emptyTextField: UITextField!
    @IBOutlet weak var bornTextField: UITextField!
    @IBOutlet weak var livingTextField: UITextField!
    @IBOutlet weak var deadTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        StandardEngine.sharedUpdates.delegate = self
        setupTextFields(StandardEngine.sharedUpdates.grid)
    }

    func engineDidUpdate(withGrid: GridProtocol) {
        setupTextFields(withGrid)
    }
    
    func setupTextFields(grid: GridProtocol) {
        emptyTextField.text = "\(grid.getCount(.Empty))"
        bornTextField.text = "\(grid.getCount(.Born))"
        livingTextField.text = "\(grid.getCount(.Living))"
        deadTextField.text = "\(grid.getCount(.Dead))"
    }
}
