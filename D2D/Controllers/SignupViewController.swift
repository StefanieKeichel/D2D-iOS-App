import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var SignUp_Cartype_TextField: UITextField!
    @IBOutlet weak var SignUp_Name_TextField: UITextField!
    @IBOutlet weak var SignUp_Email_TextField: UITextField!
    @IBOutlet weak var SignUp_Password_TextField: UITextField!
    @IBOutlet weak var SignUp_Password_repetition_TextField: UITextField!
    
    @IBAction func password_check(_ sender: Any) {
        
        if checkStrength(SignUp_Password_TextField.text ?? "") == true {
            (sender as! UITextField).backgroundColor = UIColor(red: 229/255, green: 255/255, blue: 204/255, alpha: 1)
        }else{
            (sender as! UITextField).backgroundColor = UIColor.red
//            UIColor(red: 255/255, green: 204/255, blue: 204/255, alpha: 1)
        }
        
        if (SignUp_Password_TextField.text != "" && SignUp_Password_repetition_TextField.text != "" && SignUp_Password_TextField.text == SignUp_Password_repetition_TextField.text && checkStrength(SignUp_Password_TextField.text ?? "") == true) {
            (sender as! UITextField).backgroundColor = UIColor.green
            SignUp_Password_repetition_TextField.backgroundColor = UIColor.green
        }
    }
    @IBAction func password_repetition_check(_ sender: Any) {
        if checkStrength(SignUp_Password_TextField.text ?? "") == true {
            (sender as! UITextField).backgroundColor = UIColor(red: 229/255, green: 255/255, blue: 204/255, alpha: 1)
        }else{
            (sender as! UITextField).backgroundColor = UIColor.red
        }
        
        if (SignUp_Password_TextField.text != "" && SignUp_Password_repetition_TextField.text != "" && SignUp_Password_TextField.text == SignUp_Password_repetition_TextField.text && checkStrength(SignUp_Password_TextField.text ?? "") == true) {
            (sender as! UITextField).backgroundColor = UIColor.green
            SignUp_Password_TextField.backgroundColor = UIColor.green
        }
    }
    
    var SignUp_Cartype = ""
    var SignUp_Name = ""
    var SignUp_Email = ""
    var SignUp_Password = ""
    var SignUp_Password_repetition = ""
    var loginAttempted = false
    var login_option = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func GoTo_PostLogin(_ sender: UIButton) {
        
        
        SignUp_Cartype = SignUp_Cartype_TextField.text ?? ""
        SignUp_Name = SignUp_Name_TextField.text ?? ""
        SignUp_Email = SignUp_Email_TextField.text ?? ""
        SignUp_Password = SignUp_Password_TextField.text ?? ""
        SignUp_Password_repetition = SignUp_Password_repetition_TextField.text ?? ""
        
        guard
            !SignUp_Cartype.isEmpty,
            !SignUp_Name.isEmpty,
            !SignUp_Email.isEmpty,
            !SignUp_Password.isEmpty,
            !SignUp_Password_repetition.isEmpty,
            SignUp_Password.count > 6,
            SignUp_Password == SignUp_Password_repetition
//            isValidPassword(SignUp_Password) = true
        else {
            if SignUp_Cartype.isEmpty || SignUp_Name.isEmpty || SignUp_Email.isEmpty || SignUp_Password.isEmpty  || SignUp_Password_repetition.isEmpty {
                alertUserSignUpError(a: 1)
            }else if SignUp_Password.count <= 6 {
                alertUserSignUpError(a: 2)
            }else if SignUp_Password != SignUp_Password_repetition {
                alertUserSignUpError(a: 3)
            }
            login_option = "SignUp"
            return
            
        }
    
        // Firebse Sign up
        Auth.auth().createUser(withEmail: SignUp_Email, password: SignUp_Password) {
            authResult, error in
            guard let result = authResult, error == nil else {
                print("Error creating user")
                return
            }
            let user = result.user
            print("Created User: \(user)")
            self.performSegue(withIdentifier: "RegisterToChat", sender: self)
        }
        
        func alertUserSignUpError(a: Int) {
            print(a)
            var alert = UIAlertController(title: "Security alert", message: "", preferredStyle: .alert)
            if a == 1 {
                alert = UIAlertController(title: "Security alert", message: "Fields cannot be left blank.", preferredStyle: .alert)
            }else if a == 2 {
                alert = UIAlertController(title: "Security alert", message: "Password must be at least 6 chacters.", preferredStyle: .alert)
            }else if a == 3 {
                alert = UIAlertController(title: "Security alert", message: "Passwords must match.", preferredStyle: .alert)
            }
            
            alert.addAction(UIAlertAction(title:"Okay", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
}
//    Passing variables from one ViewController to the next with this function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! PostLoginViewController
        destVC.Display_SignUp_Cartype = self.SignUp_Cartype
        destVC.Display_Login_Name = self.SignUp_Name
        destVC.Display_SignUp_EMail = self.SignUp_Email
        destVC.Display_SignUp_Password = self.SignUp_Password
        destVC.login_option = self.login_option
    }
    
//      dismiss the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        SignUp_Cartype_TextField.resignFirstResponder()
    }
    
    func checkStrength(_ password: String) ->Bool {
        print("Passwort lautet: _")
        print(password)
        
        let passwordLenth = password.count
        var containsSymbol = false
        var containsUppercase = false
        
        for character in password {
            if "ABCDEFGHIJKLMNOPQRSTUVWXYZ".contains(character) {
                containsUppercase = true
            }
            if "!#$%&\'()*+,-.;:^°/".contains(character) {
                containsSymbol = true
            }
            
        }
        
        if containsSymbol == true && containsUppercase == true && passwordLenth > 6 {
            return true
        }else {
            return false
        }
        
    }
    
}
