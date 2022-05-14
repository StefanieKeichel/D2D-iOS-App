import UIKit
import Firebase
import BCrypt

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var Login_Email_TextField: UITextField!
    @IBOutlet weak var Login_Password_TextField: UITextField!
    @IBOutlet weak var forward: UIButton!
    
    var Login_Email = ""
    var Login_Password = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func GoTo_PostLogin(_ sender: UIButton) {
        
        Login_Email = Login_Email_TextField.text ?? ""
        
        guard let Login_Email = Login_Email_TextField.text,
              let Login_Password = Login_Password_TextField.text,
              !Login_Email.isEmpty, !Login_Password.isEmpty
        else {
                  alertUserLoginError()
                  return
              }
        if
            let Login_Email = Login_Email_TextField.text {
            var hashed = ""
            do {
//                Salt must be retrieved from the database !!
//                not implemented yet
                let salt = try BCrypt.Salt()
                hashed = try BCrypt.Hash(Login_Password_TextField.text ?? "", salt: salt)
                print("Hashed result is: \(hashed)")
            }
            catch {
                print("An error occured: \(error)")
            }
            
            Auth.auth().signIn(withEmail: Login_Email, password: hashed) {  authResult, error in
            if let e = error  {
                print("Failed to log in user with email: \(Login_Email)")
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
        let destVC = segue.destination as! PostLoginViewController
        destVC.Display_Login_Name = self.Login_Email
    }
    
    @IBAction func focus_password_textfield(_ sender: UITextField) {
        Login_Email_TextField.resignFirstResponder()
        Login_Password_TextField.becomeFirstResponder()
    }
    //      dismiss the keyboard
    @IBAction func dismiss_passowrd_text_field(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
