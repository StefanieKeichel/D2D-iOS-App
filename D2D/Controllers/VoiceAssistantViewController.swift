import UIKit
import InstantSearchVoiceOverlay

class VoiceAssistant: UIViewController {

    let voiceOverlay = VoiceOverlayController()

    @IBOutlet weak var recording_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recording_button.sendActions(for: .touchUpInside)
        

    }
    @IBAction func recording_button(_ sender: UIButton) {
        
        voiceOverlay.start(on: self, textHandler: {text, final, _ in
            if final {
                print("\(text)")
//                self.navigationController?.pushViewController(Chat.storyboard, animated: true)
                self.performSegue(withIdentifier: "showchatstoryboard", sender: self)
            }
            else {
                print("In progress: \(text)")
            }
        }, errorHandler: { error in
            
        })
    }
    
}
