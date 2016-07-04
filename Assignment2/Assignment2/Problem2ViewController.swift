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

var cells = Array(count:10, repeatedValue:
    Array(count:10, repeatedValue:Bool()))
var live = Array<Array<Int>>()
var dead = Array<Array<Int>>()

//var a = 0
//var d = 0
var lives = 0

enum States{
    case liveAndFewerThan2
    case liveAnd2Or3
    case liveAndMoreThan3
    case deadAnd3
}

func initialize(){
    for _ in 0..<36{
        cells[Int(arc4random_uniform(10))][Int(arc4random_uniform(10))] = true
    }
}




class Problem2ViewController: UIViewController {
var a = 0
 var d = 0
    @IBOutlet weak var textView2: UITextView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        appendArrays()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func appendArrays(){
        for j in 0...9{
            for k in 0...9{
        if cells[j][k]==true{
            live.append(Array(arrayLiteral: j,k))
            a+=1
        }
        else{
            dead.append(Array(arrayLiteral: j,k))
            d+=1
        }
            }
        }
    }

    func numNeighbors(j: Int, k: Int)->Int{
       
        
                var l = j-1 //left
                var rt = j+1
                var b = k-1
                var t = k+1
        
                lives = 0
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
    

    @IBAction func printSomething(sender: AnyObject) {
        verdict()
        textView2.text = "Alive: \(a)\nDead: \(d)"
        
    }
    
    func verdict(){
        for j in 0..<10{
            for k in 0..<10{
                var v = cells[j][k]
                
                if v==false && numNeighbors(j, k: k)==3{v = true}
                else if v==true && numNeighbors(j, k: k)==2||numNeighbors(j, k: k)==3{v=true}
                else if v==true && numNeighbors(j, k: k)<2{v=false}
                else if v==true && numNeighbors(j, k: k)>3{v=false}
                
                 print("\(j),\(k): \(cells[j][k]), \(lives), \(v)")
            }
        }
    }

}

