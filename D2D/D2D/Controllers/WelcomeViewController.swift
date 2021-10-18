//
//  WelcomeViewController.swift
//  D2D
//
//  Created by Ahmed Eldably on 18.10.21.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initalize empty text
        titleLabel.text = ""
        let titleText = "D2D Communication"
        var charIndex = 0.0
        
        // loop on every letter in the text and show every letter every 0.1 seconds
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) {(timer) in self.titleLabel.text?.append(letter)
                
            }
            charIndex += 1
        }
    }


}

