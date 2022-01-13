//
//  SMSViewController.swift
//  D2D
//
//  Created by Ahmed Eldably on 13.01.22.
//

import UIKit
import FirebaseAuth

class SMSViewController: UIViewController {

    @IBOutlet weak var SMSTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func signInPressed(_ sender: UIButton) {
        guard let verificationCode = SMSTextField.text,
                !verificationCode.isEmpty else{
                    alertUserLoginError()
                    return
                }
        //
        AuthManager.shared.verifyCode(smsCode: verificationCode) { [weak self] success in
            guard success else { return }
        }
        self.performSegue(withIdentifier: Constants.postLogIn, sender: self)
        
        
            
    }
    
    
    
    func alertUserLoginError(message: String = "Authentication failed. Please fill in the missing information.") {
        let alert = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
        
    }
}
