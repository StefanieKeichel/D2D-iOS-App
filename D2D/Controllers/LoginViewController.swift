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
        guard let email = Login_Email_TextField.text,
              let password = Login_Password_TextField.text,
              !email.isEmpty, !password.isEmpty,
              password.count > 6 else {
                  alertUserLoginError()
                  return
              }
        if let email = Login_Email_TextField.text,
           let password = Login_Password_TextField.text {
               // firebase log in
               Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                   if let e = error  {
                       print("Failed to log in user with email: \(email)")
                       print(e)
                   } else {
                       self.performSegue(withIdentifier: "LoginToChat", sender: self)
                   }
            }
        }
            
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops", message: "Please enter the right information to log in", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:"Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
        
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
