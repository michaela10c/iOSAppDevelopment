//
//  ConfigurationsViewController.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/23/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class ConfigurationsViewController: UITableViewController, EngineDelegate {
    
    var engine = StandardEngine.sharedUpdates
    var configurations : [GridConfiguration] {
        get{
            return engine.configurations
        }
        set(newValue){
            engine.configurations = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        engine.delegate = self
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
            else{preconditionFailure("Nanny?")}
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
    func fetch(){
        let url = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")!
        let fetcher = Fetcher()
        fetcher.requestJSON(url){(json, message) in
            if let json = json{
                let correctType = json as! [AnyObject]
                let parser = GridConfigurationParser(configurations: correctType)
                self.configurations = parser.parse()!
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
        addConfigurationHelper()
    }
    
    func addConfigurationHelper(){
        configurations.append(GridConfiguration(title: "Add new configuration", points: [(0,0)])) //***********What is the form of adding a new configuration in this case?
        
        let itemRow = configurations.count - 1
        let itemPath = NSIndexPath(forRow: itemRow, inSection: 0)
        tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
        print("configuration added")
    }
    
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                               forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            configurations.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath],
                                             withRowAnimation: .Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        engine.configuration = configurations[indexPath.row]
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        
    }
    
    func engineDidUpdate(withConfigurations: [GridConfiguration]) {
        tableView.reloadData()//update the table view
    }

}
