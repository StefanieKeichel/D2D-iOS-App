import UIKit

class ViewController_PostLogin: UIViewController {

    @IBOutlet weak var Display_Name: UILabel!
    
    var Display_Name_Login = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Display_Name.text = "Welcome " + Display_Name_Login + " !"
    }
}
