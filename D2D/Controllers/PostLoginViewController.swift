import UIKit
import SwiftUI

class ViewController_PostLogin: UIViewController {
    //    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var welcome_text: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Initalize empty text
        welcome_text.text = ""
        let welcome_text = "comobi"
        var charIndex = 0.0

        // loop on every letter in the text and show every letter every 0.1 seconds
        for letter in welcome_text {
            Timer.scheduledTimer(withTimeInterval: 0.17 * charIndex, repeats: false) {(timer) in self.welcome_text.text?.append(letter)

            }
            charIndex += 1
        }

    }
    
    @IBSegueAction func swiftUIAction(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: MapView())
    }
            
}
