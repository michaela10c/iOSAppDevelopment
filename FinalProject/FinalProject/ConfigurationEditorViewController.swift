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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(animated: Bool) {
        configurationNameText.text = name
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
         print("\((StandardEngine.sharedUpdates.configuration?.points.reduce(0, combine: {$0 > $1.0 ? $0 : $1.0}))! + 1)")
        StandardEngine.sharedUpdates.rows = (StandardEngine.sharedUpdates.configuration?.points.reduce(0, combine: {$0 > $1.0 ? $0 : $1.0}))! + 1//When set to dimensions less than configuration, error.
        StandardEngine.sharedUpdates.cols = (StandardEngine.sharedUpdates.configuration?.points.reduce(0, combine: {$0 > $1.1 ? $0 : $1.1}))! + 1
        StandardEngine.sharedUpdates.grid.gridCells = gridView.grid
       
        NSNotificationCenter.defaultCenter().postNotificationName("Change Values", object: nil, userInfo: ["Change the values": gridView])
    }
}

extension ConfigurationEditorViewController: UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //Allow selection for the user
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.selectedTextRange = textField.textRangeFromPosition(textField.beginningOfDocument, toPosition: textField.endOfDocument)
    }
}
