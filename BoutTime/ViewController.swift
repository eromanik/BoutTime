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
    var timer = Timer()
    var isTimerRunning = false
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        runTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1     // decrement seconds
        let formattedSeconds = String(format:"%02i", seconds) // format seconds to include leading zero
        timerLabel.text = "0:\(formattedSeconds)" // update the label
    }
    
    
}

