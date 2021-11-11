import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var Login_Email_TextField: UITextField!
    @IBOutlet weak var Login_Password_TextField: UITextField!
    
    var Login_Email = ""
    var Login_Password = ""
    var login_option = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func GoTo_PostLogin(_ sender: UIButton) {
        if let email = Login_Email_TextField.text, let password = Login_Password_TextField.text {
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let e = error {
                    print(e)
                } else {
                    // navigate to the PostLoginViewController
                    self.performSegue(withIdentifier: "LoginToChat", sender: self)
                }
            }
            
        }
        
        login_option = "Login"
    }

//    pass data between view controllers with passSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        destination viewcontroller
        let destVC = segue.destination as! PostLoginViewController
        destVC.Display_Login_Name = self.Login_Email
        destVC.login_option = self.login_option
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Login_Password_TextField.resignFirstResponder()
    }
}
