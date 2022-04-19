import UIKit
import SwiftUI
import AVFoundation

class PostLoginViewController: UIViewController {
    
    
    @IBOutlet weak var welcome_text: UILabel!
    
    var Display_Login_Name = ""
    var Display_Login_Password = ""
    var Display_SignUp_Cartype = ""
    var Display_SignUp_Name = ""
    var Display_SignUp_EMail = ""
    var Display_SignUp_Password = ""
    var login_option = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Initalize empty text
        welcome_text.text = ""
        let welcome_text = "welcome to comobi \(Display_Login_Name)\(Display_SignUp_Name)!"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            let utterance = AVSpeechUtterance(string: "Welcome to comobi, \(self.Display_Login_Name)\(self.Display_SignUp_Name).")
            utterance.voice = AVSpeechSynthesisVoice(language: "en-USA")
            utterance.rate = 0.43
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
        }
        
        
        if login_option == "Login" {
            print("Login \nEMAIL = \(Display_Login_Name); Password = \(Display_Login_Password)")
        }else if login_option == "SignUp" {
            print("SignUp \nEMAIL = \(Display_SignUp_Name); Password = \(Display_SignUp_Password)")
        }else{print("error")}
    
    
        var charIndex = 0.0

        // loop on every letter in the text and show every letter every 0.1 seconds
        for letter in welcome_text {
            Timer.scheduledTimer(withTimeInterval: 0.12 * charIndex, repeats: false) {(timer) in self.welcome_text.text?.append(letter)

            }
            charIndex += 1
        }
        
    }
    
    @IBAction func GoTo_Chat(_ sender: UIButton) {
        
    }
//    @IBSegueAction func swiftUIAction(_ coder: NSCoder) -> UIViewController? {
//        return UIHostingController(coder: coder, rootView: MapView())
//    }
}
