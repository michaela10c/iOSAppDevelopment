//
//  ViewController.swift
//  Flo
//
//  Created by Michael Zhou on 7/5/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    
    var isGraphViewShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = String(counterView.counter)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPushButton(button: PushButtonView){
        if button.isAddButton{
            counterView.counter+=1
        }else{
            if counterView.counter > 0{
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
        
        if isGraphViewShowing{
            counterViewTap(nil)
        }
    }
    
    @IBAction func counterViewTap(gesture:UITapGestureRecognizer?){
        if (isGraphViewShowing){
            //hide graph
            UIView.transitionFromView(<#T##fromView: UIView##UIView#>, toView: <#T##UIView#>, duration: <#T##NSTimeInterval#>, options: <#T##UIViewAnimationOptions#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
            UIView.transitionFromView(graphView,
                                      toView: counterView,
                                      duration: 1.0,
//                                      options: UIViewAnimationOptions.TransitionFlipFromLeft
//                                        | UIViewAnimationOptions.ShowHideTransitionViews,
                options: UIViewAnimationOptions.TransitionFlipFromLeft | .ShowHideTransitionViews,
                                      completion: nil)
        } else {
            //show graph
            UIView.transitionFromView(counterView,
                                      toView: graphView,
                                      duration: 1.0,
                                      options: UIViewAnimationOptions.TransitionFlipFromRight
                                       | UIViewAnimationOptions.ShowHideTransitionViews,
                                      completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    
}

