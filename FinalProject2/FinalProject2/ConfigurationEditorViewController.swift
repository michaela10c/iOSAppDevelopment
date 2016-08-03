//
//  ConfigurationEditorViewController.swift
//  FinalProject2
//
//  Created by Michael Zhou on 8/3/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

struct Configuration {
    var title: String
    var positions: Array<Position>
    
    static func fromJSON(json: Dictionary<String, AnyObject>) -> Configuration {
        let title = json["title"] as! String
        
        let contents = json["contents"] as! Array<Array<Int>>
        
        let positions = contents.map { (intArray) -> Position in
            return Position(intArray.first!, intArray.last!)
        }
        
        return Configuration(title: title, positions: positions)
    }
}

import UIKit

class ConfigurationEditorViewController: UIViewController, EngineDelegate {
    
    let engine = StandardEngine.sharedInstance
    var configuration:Configuration?
    var commit: (String -> Void)?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var gridView: GridView!
    
    @IBAction func save(sender: AnyObject) {
        guard let newText = nameTextField.text, commit = commit
            else { return }
        commit(newText)
        navigationController!.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = configuration?.title
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        engine.delegate = self
        gridView.points = configuration!.positions
        gridView.setNeedsDisplay()
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        // do nothing
    }
    
    func engineDidUpdate(withConfigurations: Array<Configuration>) {
        gridView.setNeedsDisplay()
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
    
}