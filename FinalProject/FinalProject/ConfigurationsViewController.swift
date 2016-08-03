//
//  ConfigurationsViewController.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/23/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class ConfigurationsViewController: UITableViewController, EngineDelegate {
    
    @IBOutlet weak var urlTextField: UITextField!
    
    var engine = StandardEngine.sharedUpdates
    var configurations : [GridConfiguration] {
        get{
            return engine.configurations
        }
        set(newValue){
            engine.configurations = newValue
        }
    }
    var configuration = GridConfiguration(title: "Add new configuration", points: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(addConfigurationHelper), name: "Add configuration", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        engine.delegate = self
        let url = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")!
        urlTextField.text = String(url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("Configurations")
            else {
                preconditionFailure("missing default reuse identifier")
        }
        let row = indexPath.row
        guard let nameLabel = cell.textLabel else {
            preconditionFailure("wtf?")
        }
        nameLabel.text = configurations[row].title
        cell.tag = row
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let editingRow = (sender as! UITableViewCell).tag
        
        let editingString = configurations[editingRow].title
        guard let editingVC = segue.destinationViewController as? ConfigurationEditorViewController
            else{preconditionFailure("WTF?")}
        editingVC.name = editingString
        editingVC.commit = {
            (title,points) in
            self.configurations[editingRow].title = title
            self.configurations[editingRow].points = points
            let indexPath = NSIndexPath(forRow: editingRow, inSection: 0)
            self.tableView.reloadRowsAtIndexPaths([indexPath],
                                                  withRowAnimation: .Automatic)
            
        }
    }
    
    //inspired by Nathan Guerin's section
    func fetch(urlStr: String = "https://dl.dropboxusercontent.com/u/7544475/S65g.json"){
        let url = NSURL(string: urlStr)!
        let fetcher = Fetcher()
        fetcher.requestJSON(url){(json, message) in
            if let json = json{
                let correctType = json as! [AnyObject]
                let parser = GridConfigurationParser(configurations: correctType)
                self.configurations = parser.parse()!
            }
            
            if let message = message{
               let alertController = UIAlertController(title: "Wrong URL", message: message, preferredStyle: .Alert)
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: { (action) in})
                alertController.addAction(okButton)
                let op = NSBlockOperation {
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                NSOperationQueue.mainQueue().addOperation(op)
            }
            
            let op = NSBlockOperation {
                self.tableView.reloadData()
            }
            NSOperationQueue.mainQueue().addOperation(op)
        }
    }
    
    
    //inspired by Lecture 9
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurations.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    @IBAction func addConfiguration(sender: AnyObject) {
        configuration.points = []//clear the grid of any living cells
        configurations.append(configuration)
        tableView.reloadData()
    }
    
    func addConfigurationHelper(){
        for row in 0..<StandardEngine.sharedUpdates.rows{
            for col in 0..<StandardEngine.sharedUpdates.cols{
                if StandardEngine.sharedUpdates.grid.gridCells[row][col].isLiving(){
                    configuration.points.append(row,col)}
            }
        }
        configurations.append(configuration)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                               forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            configurations.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        engine.configuration = configurations[indexPath.row]
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        
    }
    
    @IBAction func clearTableAndReload(sender: AnyObject) {
        configurations.removeAll()
        tableView.reloadData()
        fetch()
    }
    
    func engineDidUpdate(withConfigurations: [GridConfiguration]) {
        tableView.reloadData()//update the table view
    }
}

extension ConfigurationsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        fetch(textField.text!)
        return true
    }
    //Allow selection for the user
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.selectedTextRange = textField.textRangeFromPosition(textField.beginningOfDocument, toPosition: textField.endOfDocument)
    }
}
