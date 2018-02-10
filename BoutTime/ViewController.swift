//
//  ViewController.swift
//  BoutTime
//
//  Created by Eric Romanik on 1/29/18.
//  Copyright © 2018 Romanik. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    var seconds: Int = 60
    weak var timer: Timer?
    var isTimerRunning = false
    var roundEvents = EventRound(events:[])
    
    var correctSound: SystemSoundID = 0
    var wrongSound: SystemSoundID = 1
    

    @IBOutlet weak var eventLabel0: UIButton!
    @IBOutlet weak var eventLabel1: UIButton!
    @IBOutlet weak var eventLabel2: UIButton!
    @IBOutlet weak var eventLabel3: UIButton!
    
    
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
    @IBOutlet weak var shakePromptLabel: UILabel!
    @IBOutlet weak var nextRoundButton: UIButton!
    
    @IBAction func nextRoundButton(_ sender: Any) {
        if roundCount <= 5 {
            startRound()
        } else {
            gameRunningFlag = false
            self.performSegue(withIdentifier: "gameViewToFinalScore", sender: self)
        }
    }
    

    @IBAction func openWebView0(_ sender: Any) {
        if !roundOpenFlag {
            selectedEvent = roundEvents.events[0]
            self.performSegue(withIdentifier: "openWebView", sender: self)
        }
    }

    @IBAction func openWebView1(_ sender: Any) {
        if !roundOpenFlag {
            selectedEvent = roundEvents.events[1]
            self.performSegue(withIdentifier: "openWebView", sender: self)
        }
    }
    
    @IBAction func openWebView2(_ sender: Any) {
        if !roundOpenFlag {
            selectedEvent = roundEvents.events[2]
            self.performSegue(withIdentifier: "openWebView", sender: self)
        }
    }
    
    @IBAction func openWebView3(_ sender: Any) {
        if !roundOpenFlag {
            selectedEvent = roundEvents.events[3]
            self.performSegue(withIdentifier: "openWebView", sender: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventLabel0.contentHorizontalAlignment = .left
        eventLabel1.contentHorizontalAlignment = .left
        eventLabel2.contentHorizontalAlignment = .left
        eventLabel3.contentHorizontalAlignment = .left
        loadCorrectAnswerSound()
        loadWrongAnswerSound()
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

    override func viewWillAppear(_ animated: Bool) {
        if !gameRunningFlag {
            roundCount = 0
            correctRoundCount = 0
            gameRunningFlag = true
            startRound()
        }
       
    }
    
    func startRound() {
        roundOpenFlag = true
        roundCount += 1
        seconds = 60
        nextRoundButton.isHidden = true
        timerLabel.text = "0:60"
        timerLabel.isHidden = false
        shakePromptLabel.text = "Shake to complete"
        runTimer()
        roundEvents = generateEventRound()
        displayEvents()
    }
    
    func endRound() {
        roundOpenFlag = false
        let image: UIImage
        if roundEvents.isOrderedCorrectly() {
            // set next round button background to success and increment correct answer count
            AudioServicesPlaySystemSound(correctSound)
            image = UIImage(named: "next_round_success.png")!
            correctRoundCount += 1
        } else {
            // set next round button background to fail
            AudioServicesPlaySystemSound(wrongSound)
            image = UIImage(named: "next_round_fail.png")!
        }
        nextRoundButton.setBackgroundImage(image, for: UIControlState.normal)
        shakePromptLabel.text = "Tap events to learn more"
        
        // display next round button
        nextRoundButton.isHidden = false
        
        // delete timer and hide label
        timer?.invalidate()
        timerLabel.isHidden = true
    }
    
    func runTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func displayEvents() {
        var attributedString = NSMutableAttributedString(string: roundEvents.events[0].eventDescription)
        eventLabel0.setAttributedTitle(attributedString, for: .normal)
        attributedString = NSMutableAttributedString(string: roundEvents.events[1].eventDescription)
        eventLabel1.setAttributedTitle(attributedString, for: .normal)
        attributedString = NSMutableAttributedString(string: roundEvents.events[2].eventDescription)
        eventLabel2.setAttributedTitle(attributedString, for: .normal)
        attributedString = NSMutableAttributedString(string: roundEvents.events[3].eventDescription)
        eventLabel3.setAttributedTitle(attributedString, for: .normal)
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
    
    func loadCorrectAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "CorrectDing", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctSound)
    }
    
    func loadWrongAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongSound)
    }
    
}

