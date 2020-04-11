//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
       var player: AVAudioPlayer!

    
    var eggTimes = ["Soft": 180, "Medium": 240, "Hard": 420]
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var done_label: UILabel!
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    func playSound() {
        guard (Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") != nil) else {return}
        
    }
    
    @IBAction func startEggTime(_ sender: UIButton) {
        timer.invalidate()
      
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0
        secondsPassed = 0
        done_label.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

    }
    
    @objc func updateCounter() {
        let path = Bundle.main.path(forResource: "alarm_sound", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        }
        else {
            timer.invalidate()
            done_label.text = "Done!"
           let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                       player = try! AVAudioPlayer(contentsOf: url!)
                       player.play()
            

        }
    }
    
}
