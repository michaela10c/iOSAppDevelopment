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
    
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    
    var isGraphViewShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = String(counterView.counter)
        checkTotal()
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
            //counterViewTap(nil)
        }
    }
    
    @IBAction func counterViewTap(gesture:UITapGestureRecognizer?){
        if (isGraphViewShowing){
            //hide graph
            UIView.transitionFromView(graphView,
                                      toView: counterView,
                                      duration: 1.0,
                                     options: [UIViewAnimationOptions.TransitionFlipFromLeft
                                        , UIViewAnimationOptions.ShowHideTransitionViews],
                                      completion: nil)
        } else {
            //show graph
            UIView.transitionFromView(counterView,
                                      toView: graphView,
                                      duration: 1.0,
                                      options: [UIViewAnimationOptions.TransitionFlipFromRight
                                       , UIViewAnimationOptions.ShowHideTransitionViews],
                                      completion: nil)
            setUpGraphDisplay()
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    
    func setUpGraphDisplay(){
        let numDays: Int = 7
        
        //1. replace last day with today's data
        graphView.graphPoints[graphView.graphPoints.count-1] = counterView.counter
        
        //2. indicate that graph needs to be redrawn
        graphView.setNeedsDisplay()
        maxLabel.text = "\(graphView.graphPoints.maxElement())"
        
        //3. calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0, combine: +) / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        
        //labels to today
        
        //4. today's DATE!!!
        _ = NSDateFormatter()
        let calendar = NSCalendar.currentCalendar()
        let componentOptions: NSCalendarUnit = .NSWeekdayCalendarUnit
        let components = calendar.components(componentOptions, fromDate: NSDate())
        
        var weekday = components.weekday
        
        let days = ["S", "S", "M", "T", "W", "T", "F"]
        
        //5. set up day name labels with correct day
        for i in (1...days.count).reverse(){
            if let labelView = graphView.viewWithTag(i) as? UILabel{
                if weekday == 7{
                    weekday = 0
                }
                labelView.text = "\(days[weekday])"
                weekday -= 1
                if weekday < 0{
                    weekday = days.count - 1
                }
            }
        }
        
    }
    
    func checkTotal() {
        let medalView = MedalView()
        if counterView.counter >= 8 {
            medalView.showMedal(true)
        } else {
            medalView.showMedal(false)
        }
    }
    
    
}

