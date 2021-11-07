import UIKit

class ViewController_Login: UIViewController {
    
    @IBOutlet weak var Login_Email_TextField: UITextField!
    @IBOutlet weak var Login_Password_TextField: UITextField!
    
    var Login_Email = ""
//    var Login_Password = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func GoTo_PostLogin(_ sender: Any) {
        self.Login_Email = Login_Email_TextField.text!
//        self.Login_Password = Login_Password_TextField.text!
//        performSegue(withIdentifier: "Send_Login_Data", sender: self)
    }

//    pass data between view controllers with passSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        destination viewcontroller
        let destVC = segue.destination as! ViewController_PostLogin
        destVC.Display_Name_Login = self.Login_Email
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Login_Password_TextField.resignFirstResponder()
    }
}
