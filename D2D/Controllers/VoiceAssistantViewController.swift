import UIKit
import InstantSearchVoiceOverlay
import AVFoundation


class VoiceAssistant: UIViewController {

    let voiceOverlay = VoiceOverlayController()
    var user_message = ""
    var user_name = ""

    @IBOutlet weak var recording_button: UIButton!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.tintColor = UIColor(red: 251/255, green: 247/255, blue: 255/255, alpha: 1.0)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        super.viewDidLoad()
        
        let utterance1 = AVSpeechUtterance(string: "What message would you like to send?")
        utterance1.voice = AVSpeechSynthesisVoice(language: "en-USA")
        utterance1.rate = 0.4
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.recording_button.sendActions(for: .touchUpInside)
            
        }
    }
    
    
    @IBAction func recording_button(_ sender: UIButton) {
        
        
        voiceOverlay.start(on: self, textHandler: { [self]text, final, _ in
            if final {
                user_message = "\(text)"
                self.performSegue(withIdentifier: "showchatstoryboard", sender: self)
            }
            else {
                print("In progress: \(text)")
                user_message = ""
            }
        }, errorHandler: { error in
        })
    }

    @IBAction func GoTo_Chat(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showchatstoryboard", sender: self)
    }
    
    //    Passing variables from one ViewController to the next with this function
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destVC = segue.destination as! ChatViewController
            destVC.voicemessage = self.user_message
            destVC.User_Name = self.user_name   
        }
}

