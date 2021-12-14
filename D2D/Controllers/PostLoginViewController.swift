import UIKit
import SwiftUI

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
        let welcome_text = "welcome to comobi, \(Display_Login_Name)\(Display_SignUp_Name)!"
        
        if login_option == "Login" {
            print("Login \nEMAIL = \(Display_Login_Name); Password = \(Display_Login_Password)")
        }else if login_option == "SignUp" {
            print("SignUp \nEMAIL = \(Display_SignUp_Name); Password = \(Display_SignUp_Password)")
        }else{print("error")}
    
    
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
