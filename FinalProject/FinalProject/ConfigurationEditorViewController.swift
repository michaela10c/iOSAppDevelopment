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
    var commit: ((String,[(Int,Int)]) -> Void)?
    
    @IBOutlet weak var gridView: GridView!
    
    @IBOutlet weak var configurationNameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNameText.text = name
       // NSNotificationCenter.defaultCenter().postNotificationName("drawGrid", object: nil, userInfo: ["drawOriginalGrid": ])
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
        var points : [(Int, Int)] = []
        for row in 0..<gridView.rows{
            for col in 0..<gridView.cols{
                if gridView.grid[row][col] == .Living{
                    points.append(row,col)
                }
            }
        }
        commit(newText, points)
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func reloadGrid(sender: AnyObject) {
        
    }
}

extension ConfigurationEditorViewController: UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
