//
//  WelcomeViewController.swift
//  D2D
//
//  Created by Ahmed Eldably on 18.10.21.
//

import UIKit
import MultipeerConnectivity

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func pairWithDevice(_ sender: UIButton) {
        let ac = UIAlertController(title: "Ready to connect with others", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default)) // Adding a closure to host a session
        ac.addAction(UIAlertAction(title: "Join a session", style: .default)) // Adding a closure to host a session
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        present(ac, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initalize empty text
        titleLabel.text = ""
        let titleText = Constants.appName
        var charIndex = 0.0
        
        // loop on every letter in the text and show every letter every 0.1 seconds
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) {(timer) in self.titleLabel.text?.append(letter)
                
            }
            charIndex += 1
        }
    }

}

