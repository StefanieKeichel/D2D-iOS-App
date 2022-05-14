import UIKit

class ViewController_SignUp: UIViewController {

    @IBOutlet weak var SignUp_Cartype_TextField: UITextField!
    @IBOutlet weak var SignUp_Name_TextField: UITextField!
    @IBOutlet weak var SignUp_Email_TextField: UITextField!
    @IBOutlet weak var SignUp_Password_TextField: UITextField!
    @IBOutlet weak var SignUp_Password_again_TextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var SignUp_Cartype = ""
    var SignUp_Name = ""
    var SignUp_Email = ""
    var SignUp_Password = ""
    var SignUp_Password_again = ""
    var loginAttempted = false
    var login_option = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func GoTo_PostLogin(_ sender: Any) {
        self.SignUp_Cartype = SignUp_Cartype_TextField.text!
        self.SignUp_Name = SignUp_Name_TextField.text!
        self.SignUp_Email = SignUp_Email_TextField.text!
        self.SignUp_Password = SignUp_Password_TextField.text!
        self.SignUp_Password_again = SignUp_Password_again_TextField.text!
        
//        check if Passwords are matching
        if SignUp_Password_TextField.text == SignUp_Password_again_TextField.text! {
            print("correct")
            loginAttempted = true
        }else{
            print("false")
        }
        
        
        if SignUp_Email_TextField.text!.isEmpty || SignUp_Cartype_TextField.text!.isEmpty {
                return
        }
        if SignUp_Cartype_TextField.text!.isEmpty {
            print("please enter your cartype")
            
        }
        if SignUp_Name_TextField.text!.isEmpty {
            print("please enter your name")
            
        }
        if SignUp_Password_TextField.text!.isEmpty {
            print("please enter a password")
        }
        
        if SignUp_Password_again_TextField.text!.isEmpty {
            print("please reenter your chosen password")
        }
        
        login_option = "SignUp"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ViewController_PostLogin
        destVC.Display_SignUp_Cartype = self.SignUp_Cartype
        destVC.Display_Login_Name = self.SignUp_Name
        destVC.Display_SignUp_EMail = self.SignUp_Email
        destVC.Display_SignUp_Password = self.SignUp_Password
        destVC.login_option = self.login_option
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        SignUp_Cartype_TextField.resignFirstResponder()
    }
}
