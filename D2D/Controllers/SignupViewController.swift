import UIKit
import FirebaseAuth
import BCrypt


class SignupViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var SignUp_Cartype_TextField: UITextField!
    @IBOutlet weak var SignUp_Name_TextField: UITextField!
    @IBOutlet weak var SignUp_Email_TextField: UITextField!
    @IBOutlet weak var SignUp_Password_TextField: UITextField!
    @IBOutlet weak var SignUp_Password_repetition_TextField: UITextField!
    @IBOutlet weak var GoTo_PostLogin_Button: UIButton!
    
    var SignUp_Cartype = ""
    var SignUp_Name = ""
    var SignUp_Email = ""
    var SignUp_Password = ""
    var SignUp_Password_repetition = ""
    var loginAttempted = false
    
//    Set up the pickerView
    let cartype_suggestions = ["Audi","BMW","Mercedes-Benz","Opel","Porsche","Volkswagen (VW)", "Tesla"]
    var pickerView = UIPickerView()
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cartype_suggestions.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cartype_suggestions[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SignUp_Cartype_TextField.text = cartype_suggestions[row]
        SignUp_Cartype_TextField.resignFirstResponder()
    }
    
    
//    IBACTIONS ////////////////////////////////////////////////////////////
    @IBAction func cartype_change(_ sender: Any) {
        if cartype_suggestions.contains(SignUp_Cartype_TextField.text ?? "") == false {
            self.view.endEditing(true)
            SignUp_Cartype_TextField.text = ""
        }
    }

    @IBAction func password_check(_ sender: Any) {
        if checkStrength(SignUp_Password_TextField.text ?? "") == true {
            (sender as! UITextField).backgroundColor = UIColor(red: 229/255, green: 255/255, blue: 204/255, alpha: 1)
        }else{
            (sender as! UITextField).backgroundColor = UIColor.red
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
    
    
    @IBAction func name_finished_editing(_ sender: UITextField) {
        SignUp_Name = SignUp_Name_TextField.text ?? ""
        if checkForIllegalCharacters(string: SignUp_Name) == true {
            alertUserSignUpError(a: 5)
            self.view.endEditing(true)
            SignUp_Name_TextField.text = ""
        }
    }
    
    @IBAction func email_finished_editing(_ sender: UITextField) {
        SignUp_Email = SignUp_Email_TextField.text ?? ""
        if checkForIllegalCharacters(string: SignUp_Email) == true {
            alertUserSignUpError(a: 5)
            self.view.endEditing(true)
            SignUp_Email_TextField.text = ""
        }
    }
    
    
    @IBAction func password_finished_editing(_ sender: UITextField) {
        SignUp_Password = SignUp_Password_TextField.text ?? ""
        if checkForIllegalCharacters_in_password(string: SignUp_Password) == true {
            alertUserSignUpError(a: 5)
            self.view.endEditing(true)
            SignUp_Password_TextField.text = ""
        }
        
//        import text file of compromised passwords
//        as soon as the Password was entered by the user
        if let filepath = Bundle.main.path(forResource: "hackedpasswords", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                if contents.contains(SignUp_Password_TextField.text ?? "")  {
                    alertUserSignUpError(a: 4)
                    self.view.endEditing(true)
                    SignUp_Password_TextField.text = ""
                }
            } catch {
                print("contents could not be loaded")
            }
        } else {
                print("hackedpasswords.txt not found!")
        }
    }
    
    @IBAction func password_again_finished_editing(_ sender: UITextField) {
        SignUp_Password_repetition = SignUp_Password_repetition_TextField.text ?? ""
        if checkForIllegalCharacters_in_password(string: SignUp_Password_repetition) == true {
            alertUserSignUpError(a: 5)
            self.view.endEditing(true)
            SignUp_Password_repetition_TextField.text = ""
        }
        
    }
    

    
    @IBAction func GoTo_PostLogin(_ sender: UIButton) {
        
        SignUp_Cartype = SignUp_Cartype_TextField.text ?? ""
        SignUp_Name = SignUp_Name_TextField.text ?? ""
        SignUp_Email = SignUp_Email_TextField.text ?? ""
        SignUp_Password = SignUp_Password_TextField.text ?? ""
        SignUp_Password_repetition = SignUp_Password_repetition_TextField.text ?? ""
  
//        check if email is already used
//        Auth.reference().child(SignUp_Email).child(self.SignUp_Email_TextField.text!).observeSingleEvent(of: .value, with: {(usernameSnap) in
//                if usernameSnap.exists(){
//                print("This username already exists")
//                }else{
//                }
//            })
       //////////////////
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
            return
        }
        
        var hashed = ""
        do {
            let salt = try BCrypt.Salt()
            hashed = try BCrypt.Hash(SignUp_Password_TextField.text ?? "", salt: salt)
            
//          Database Sign up
//          To-Do: Salt has to be saved as well
            Auth.auth().createUser(withEmail: SignUp_Email, password: hashed) {
//                , salt: salt
                authResult, error in
                guard let result = authResult, error == nil else {
                    print("Error creating user")
                    return
                }
                let user = result.user
                print("Created User: \(user)")
            }
        }
        catch {
            print("An error occured: \(error)")
//            emergency procedure
        }
        

}
    
//    jump into the next textfields
    @IBAction func focus_name_textfield(_ sender: UITextField) {
        SignUp_Cartype_TextField.resignFirstResponder()
        SignUp_Name_TextField.becomeFirstResponder()
    }
    @IBAction func focus_email_textfield(_ sender: UITextField) {
        SignUp_Name_TextField.resignFirstResponder()
        SignUp_Email_TextField.becomeFirstResponder()
    }
        
    @IBAction func focus_password_textfield(_ sender: UITextField) {
        SignUp_Email_TextField.resignFirstResponder()
        SignUp_Password_TextField.becomeFirstResponder()
    }
    
    @IBAction func focus_passwordagain_textfield(_ sender: UITextField) {
        SignUp_Password_TextField.resignFirstResponder()
        SignUp_Password_repetition_TextField.becomeFirstResponder()
    }
    //      dismiss the keyboard
    @IBAction func dismiss_lasttextfield(_ sender: UITextField) {
        SignUp_Password_repetition_TextField.resignFirstResponder()
        GoTo_PostLogin_Button.becomeFirstResponder()
    }
    
    
    
    //  override FUNCTIONS //////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
            pickerView.delegate = self
            pickerView.dataSource = self
            SignUp_Cartype_TextField.inputView = pickerView
            
        }
        
    
    
//    Passing variables from one ViewController to the next with this function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! PostLoginViewController
        destVC.Display_SignUp_Cartype = self.SignUp_Cartype
        destVC.Display_Login_Name = self.SignUp_Name
        destVC.Display_SignUp_EMail = self.SignUp_Email
        destVC.Display_SignUp_Password = self.SignUp_Password
    }

    //    FUNCTIONS //////////////////////////////////////////////////////////
    
    func checkStrength(_ password: String) ->Bool {
        
        let passwordLength = password.count
        var containsSymbol = false
        var containsUppercase = false
        
        for character in password {
            if "ABCDEFGHIJKLMNOPQRSTUVWXYZ".contains(character) {
                containsUppercase = true
            }
            if "!#$%&\'()*+,-.;:^°/@".contains(character) {
                containsSymbol = true
            }
        }
        
        if containsSymbol == true && containsUppercase == true && passwordLength > 6 {
            return true
        }else {
            return false
        }
    }
 
    func checkForIllegalCharacters(string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@.-()")
        .union(.newlines)
        .union(.illegalCharacters)
        .union(.controlCharacters)

        if string.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
            return true
        } else {
            return false
        }
        
    }
    
    func checkForIllegalCharacters_in_password(string: String) -> Bool {
        let illegalCharacters = CharacterSet(charactersIn: "<>{}&'\\'?+'\"")
        .union(.newlines)
        .union(.illegalCharacters)
        .union(.controlCharacters)

        if string.rangeOfCharacter(from: illegalCharacters) != nil {
            return true
        } else {
        return false
        }
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
        }else if a == 4 {
            alert = UIAlertController(title: "Security alert", message: "The entered password has been compromised in the past! \n Please enter a new password.", preferredStyle: .alert)
        }else if a == 5 {
            alert = UIAlertController(title: "Security alert", message: "Illegal characters detected in input field", preferredStyle: .alert)
        }
        
        alert.addAction(UIAlertAction(title:"Okay", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
}
