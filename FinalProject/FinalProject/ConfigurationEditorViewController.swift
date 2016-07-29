//
//  ConfigurationEditorViewController.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/23/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class ConfigurationEditorViewController: UIViewController {

    var name: String?
    var commit: (String -> Void)?
    
    @IBOutlet weak var configurationNameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNameText.text = name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveConfiguration(sender: AnyObject) {
        guard let newText = configurationNameText.text, commit = commit
            else{return}
        commit(newText)
        navigationController!.popViewControllerAnimated(true)
    }
}
