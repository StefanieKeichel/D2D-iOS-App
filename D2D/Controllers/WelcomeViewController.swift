//
//  WelcomeViewController.swift
//  D2D
//
//  Created by Ahmed Eldably on 18.10.21.
//
import UIKit
import AVFoundation

class WelcomeViewController: UIViewController {
    
    
//    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sleep(1)
        let utterance = AVSpeechUtterance(string: "Welcome to Comobi")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-USA")
        utterance.rate = 0.5
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
        
        // Initalize empty text
//        titleLabel.text = ""
//        let titleText = Constants.appName
//        var charIndex = 0.0
//
//        // loop on every letter in the text and show every letter every 0.1 seconds
//        for letter in titleText {
//            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) {(timer) in self.titleLabel.text?.append(letter)
//
//            }
//            charIndex += 1
//        }
    }


}
