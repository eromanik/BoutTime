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
    
    @IBAction func eventButtonDown0(_ sender: Any) {
        roundEvents.events.swapAt(0, 1)
        displayEvents()
    }
    @IBAction func eventButtonUp1(_ sender: Any) {
        roundEvents.events.swapAt(0, 1)
        displayEvents()
    }
    @IBAction func eventButtonDown1(_ sender: Any) {
        roundEvents.events.swapAt(1, 2)
        displayEvents()
    }
    @IBAction func eventButtonUp2(_ sender: Any) {
        roundEvents.events.swapAt(1, 2)
        displayEvents()
    }
    @IBAction func eventButtonDown2(_ sender: Any) {
        roundEvents.events.swapAt(2, 3)
        displayEvents()
    }
    @IBAction func eventButtonUp3(_ sender: Any) {
        roundEvents.events.swapAt(2, 3)
        displayEvents()
    }
    
    
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
    
    // detect shake event and end round if shaken
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            endRound()
        }
    }

    func startRound() {
        runTimer()
        roundEvents = generateEventRound()
        displayEvents()
    }
    
    func endRound() {
        if checkAnswers() {
            // set next round button background to success and increment correct answer count
            
        } else {
            // set next round button background to fail
            
        }
        
        // display next round button
        nextRoundButton.isHidden = false
        
        // delete timer
        timer?.invalidate()
        
        // increment question count
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
            endRound()
        }
        
        
    }
    
}

