import UIKit
import FirebaseAuth
import BCryptSwift

class SignupViewController: UIViewController {

    @IBOutlet weak var SignUp_Cartype_TextField: UITextField!
    @IBOutlet weak var SignUp_Name_TextField: UITextField!
    @IBOutlet weak var SignUp_Email_TextField: UITextField!
    @IBOutlet weak var SignUp_Password_TextField: UITextField!
    @IBOutlet weak var SignUp_Password_again_TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func GoTo_PostLogin(_ sender: UIButton) {
        
        guard let email = SignUp_Email_TextField.text,
              let password = SignUp_Password_TextField.text,
              !email.isEmpty,
              !password.isEmpty,
              !password.isEmpty else {
                  alertUserSignUpError()
                  return
              }
        // Check if the email given is valid
        if !isValidEmail(email){
            alertUserSignUpError(message: "The given email is invalid. Pleace check once again.")
            return
        }
        // check the password given is valid
        if !isValidPassword(password: password) {
            alertUserSignUpError(message: "Please type the passowrd with at least one capital letter, one number, and one special character.")
            return
            
        }
        // Hashing the password with Swift
        
        do {
            let salt = try BCryptSwift.generateSalt()
            let hashed = try BCryptSwift.hashPassword(password, withSalt: salt)
            print("Hashed result is: \(hashed)")
        }
        catch {
            print("An error occured: \(error)")
        }
        
        // Firebse Sign up
        Auth.auth().createUser(withEmail: email, password: password) {
            authResult, error in
            guard let result = authResult, error == nil else {
                print("Error creating user")
                return
            }
            
            self.performSegue(withIdentifier: "RegisterToChat", sender: self)
            
        }
        
        var bytes = [Int8](repeating: 0, count: 10)
        let status = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)

        if status == errSecSuccess { // Always test the status.
            print(bytes)
            // Prints something different every time you run.
        }
        
        // alert sign up error
        func alertUserSignUpError(message: String = "Please enter your information to create a new account") {
            let alert = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title:"Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }

        // is the email valid
        func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
        
        // is the paassword valid
        func isValidPassword(password : String) -> Bool{

            let capitalLetter  = ".*[A-Z]+.*"
            let passwordTest = NSPredicate(format:"SELF MATCHES %@", capitalLetter)
            let ifCapital = passwordTest.evaluate(with: password)

            let numberRegEx  = ".*[0-9]+.*"
            let passwordTest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
            let ifNumber = passwordTest1.evaluate(with: password)

            let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
            let passwordTest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
            let ifSpecial = passwordTest2.evaluate(with: password)

            return ifCapital && ifNumber && ifSpecial
        }
    }
}
