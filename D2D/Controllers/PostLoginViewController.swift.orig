import UIKit
import SwiftUI

class ViewController_PostLogin: UIViewController {
<<<<<<< HEAD

    @IBOutlet weak var Display_Name: UILabel!
    
    var Display_Login_Name = ""
    var Display_Login_Password = ""
    var Display_SignUp_Cartype = ""
    var Display_SignUp_Name = ""
    var Display_SignUp_EMail = ""
    var Display_SignUp_Password = ""
    var login_option = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Display_Name.text = "Welcome \(Display_Login_Name) !"
        
        if login_option == "Login" {
            print("Login \nEMAIL = \(Display_Login_Name); Password = \(Display_Login_Password)")
        }else if login_option == "SignUp" {
            print("SignUp \nEMAIL = \(Display_SignUp_Name); Password = \(Display_SignUp_Password)")
        }
        
    }
=======
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

    }
    
    @IBSegueAction func swiftUIAction(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: MapView())
    }
>>>>>>> 801f1bc88f7f1906b487e59819ad4a358b8fadb7
}
