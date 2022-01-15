import UIKit
import Firebase
import BCryptSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var Login_Email_TextField: UITextField!
    @IBOutlet weak var Login_Password_TextField: UITextField!
    
    let logs = MyLogs()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func GoTo_PostLogin(_ sender: UIButton) {
        guard let email = Login_Email_TextField.text,
              let password = Login_Password_TextField.text,
              !email.isEmpty, !password.isEmpty else {
                  alertUserLoginError()
                  return
              }
        // log in attempts exceeded
        logs.loginAttempt()
        
        // compare hashed value
        BCryptSwift.verifyPassword(password, matchesHash: password)
        // firebase log in
       Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
           if let e = error  {
               print("Failed to log in user with email: \(email)")
               print(e)
           } else {
               self.performSegue(withIdentifier: "LoginToChat", sender: self)
           }
        }
        if Int(logs.loginAttempt()) > 1{
            alertUserLoginError(message: "You're fucked up.")
            return
        }
        
    }
    
    
    func alertUserLoginError(message: String = "Authentication failed. Please fill in the missing information.") {
        let alert = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:"Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
        
    }
}
