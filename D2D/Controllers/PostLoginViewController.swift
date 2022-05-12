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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Initalize empty text
        welcome_text.text = ""
        let welcome_text = "welcome to comobi, \(Display_Login_Name)\(Display_SignUp_Name)!"
        var charIndex = 0.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
                    let utterance = AVSpeechUtterance(string: welcome_text)
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-USA")
                    utterance.rate = 0.43
                    let synthesizer = AVSpeechSynthesizer()
                    synthesizer.speak(utterance)
                }
        
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
    
    @IBAction func GoTo_VoiceAssistant(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "GoTo_VoiceAssistant", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! VoiceAssistant
        if Display_Login_Name == ""{
            destVC.user_name = self.Display_SignUp_Name}
        else if Display_SignUp_Name == ""{
            destVC.user_name = self.Display_Login_Name}
    }
        
}
