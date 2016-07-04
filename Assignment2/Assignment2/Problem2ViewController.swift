//
//  Problem2ViewController.swift
//  Assignment2
//
//  Created by Michael Zhou on 2016/6/30.
//  Copyright © 2016年 Michael Zhou. All rights reserved.
//

import UIKit
import Darwin
import Swift
import Foundation

var cells = Array(count:10, repeatedValue:
    Array(count:10, repeatedValue:Bool()))
var live = Array<Array<Int>>()
var dead = Array<Array<Int>>()


var a = 0
var d = 0

enum Neighbors: Int{
    case zero = 0
    case one, two, three, four, five, six, seven, eight
}

struct Cell{
    var x = 0
    var y = 0

}

func sortIt(){
    a = 0
    d = 0
    for x in 0..<10{
        for y in 0..<10{
            if arc4random_uniform(3) == 1 {
                cells[x][y] = true
                a+=1
                live.append(Array(arrayLiteral: x,y))
                //print("\(a)")
            }
            else{d+=1}
        }
    }
}

class Problem2ViewController: UIViewController {

    
    @IBOutlet weak var textView2: UITextView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        sortIt()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numNeighbors(j: Int, k: Int) -> Int{
        
        
        
        var l = j-1 //left
        var rt = j+1
        var b = k-1
        var t = k+1
        
        var lives = 0
       
        
        if cells[j][k]==true{a+=1;live.append(Array(arrayLiteral: j,k))}
        else {d+=1}
        
        if(l == -1){l=9}
        if(l==10){l=0}
        
        if(rt == -1){rt=9}
        if(rt==10){rt=0}
        
        if(t == -1){t=9}
        if(t==10){t=0}
        
        if(b == -1){b=9}
        if(b==10){b=0}
        
        if cells[j][t]==true{lives+=1}
        if cells[rt][k]==true{lives+=1}
        if cells[j][b]==true{lives+=1}
        if cells[l][k]==true{lives+=1}
        if cells[rt][t]==true{lives+=1}
        if cells[l][b]==true{lives+=1}
        if cells[l][t]==true{lives+=1}
        if cells[rt][b]==true{lives+=1}
        
        
        
        return lives
        
        
}
    
    func appendArrays(){
        a = 0
        d = 0
        for j in 0...9{
            for k in 0...9{
                if let someValue = Neighbors(rawValue: numNeighbors(j, k: k)){
                    switch someValue{
                        case .zero,.one:
                            cells[j][k] = false
                        case .two:
                            if cells[j][k]==true{
                                cells[j][k] = true}
                            else{cells[j][k] = false}
                        case .three:
                            cells[j][k] = true
                        default:
                            cells[j][k] = false
                    }
                    

                }
            }
        }
    }
    
    
    @IBAction func printSomething(sender: AnyObject) {
        textView2.text = "Alive: \(a)\nDead: \(d)"
        appendArrays()
    }
    

}

