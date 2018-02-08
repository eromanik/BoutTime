//
//  ViewController.swift
//  BoutTime
//
//  Created by Eric Romanik on 1/29/18.
//  Copyright © 2018 Romanik. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var seconds: Int = 60
    weak var timer: Timer?
    var isTimerRunning = false
    var roundEvents = EventRound(events:[])
    
    @IBOutlet weak var eventLabel0: UILabel!
    @IBOutlet weak var eventLabel1: UILabel!
    @IBOutlet weak var eventLabel2: UILabel!
    @IBOutlet weak var eventLabel3: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextRoundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startRound()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startRound() {
        runTimer()
        roundEvents = generateEventRound()
        displayEvents()
    }
    
    func runTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func displayEvents() {
        eventLabel0.text = roundEvents.events[0].eventDescription
        eventLabel1.text = roundEvents.events[1].eventDescription
        eventLabel2.text = roundEvents.events[2].eventDescription
        eventLabel3.text = roundEvents.events[3].eventDescription
    }
    
    @objc func updateTimer() {
        seconds -= 1
        let formattedSeconds = String(format:"%02i", seconds) // format seconds to include leading zero
        timerLabel.text = "0:\(formattedSeconds)"
        
        // when seconds run out, check answers
        if seconds == 0 {
            if checkAnswers() {
                
                
            } else {
                nextRoundButton.isHidden = false
            }
            timer?.invalidate()
        }
        
        
    }
    
}

