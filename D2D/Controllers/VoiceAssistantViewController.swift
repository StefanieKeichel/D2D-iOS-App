import UIKit
import InstantSearchVoiceOverlay

class VoiceAssistant: UIViewController {

    let voiceOverlay = VoiceOverlayController()
    var user_message = ""

    @IBOutlet weak var recording_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(red: 251/255, green: 247/255, blue: 255/255, alpha: 1.0)
        recording_button.sendActions(for: .touchUpInside)
    }
    @IBAction func recording_button(_ sender: UIButton) {
        
        voiceOverlay.start(on: self, textHandler: { [self]text, final, _ in
            if final {
                print("\(text)")
                user_message = "\(text)"
//                predefined message for demo day
                user_message = user_message.replacingOccurrences(of: "Send message to the blue VW ", with: "",
                    options: NSString.CompareOptions.literal, range:nil)
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
        }
}

