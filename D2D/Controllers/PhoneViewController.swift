//
//  PhoneViewController.swift
//  D2D
//
//  Created by Ahmed Eldably on 13.01.22.
//

import UIKit
import FirebaseAuth


class PhoneViewController: UIViewController {

    @IBOutlet weak var phoneNumberField: UITextField!
    
    private var verificationID: String?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func signInPressed(_ sender: UIButton) {
        guard let phoneNumber = phoneNumberField.text,
                !phoneNumber.isEmpty else{
                    alertUserLoginError()
                    return
                }
        
        //
        AuthManager.shared.startAuth(phoneNumber: phoneNumber) { [weak self] success in
            guard success else {return}
        }
        self.performSegue(withIdentifier: Constants.SMSScreen, sender: self)

        
    }
      
        
        
    
    
    
    func alertUserLoginError(message: String = "Authentication failed. Please fill in the missing information.") {
        let alert = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
        
    }
}
