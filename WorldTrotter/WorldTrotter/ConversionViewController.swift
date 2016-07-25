//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Michael Zhou on 7/24/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController{
    
    @IBOutlet weak var CelsiusLabel: UILabel!
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text where !text.isEmpty {
            CelsiusLabel.text = text
        }
        else {
            CelsiusLabel.text = "???"
        }
    }
}
