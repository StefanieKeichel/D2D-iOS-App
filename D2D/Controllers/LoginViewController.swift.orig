import UIKit

class ViewController_Login: UIViewController {
    
<<<<<<< HEAD
    @IBOutlet weak var Login_Email_TextField: UITextField!
    @IBOutlet weak var Login_Password_TextField: UITextField!
    
    var Login_Email = ""
    var Login_Password = ""
    var login_option = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func GoTo_PostLogin(_ sender: Any) {
        self.Login_Email = Login_Email_TextField.text!
        self.Login_Password = Login_Password_TextField.text!
        
        login_option = "Login"
=======
    override func viewDidLoad() {
        super.viewDidLoad()
>>>>>>> 801f1bc88f7f1906b487e59819ad4a358b8fadb7
    }

//    pass data between view controllers with passSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        destination viewcontroller
        let destVC = segue.destination as! ViewController_PostLogin
        destVC.Display_Login_Name = self.Login_Email
        destVC.login_option = self.login_option
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Login_Password_TextField.resignFirstResponder()
    }
}
