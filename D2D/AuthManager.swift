//
//  AuthManager.swift
//  D2D
//
//  Created by Ahmed Eldably on 12.01.22.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    private var verificationId: String?
    
    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] VerificationId, error in
            guard let VerificationId = VerificationId, error == nil else {
                completion(false)
                return
            }
            self?.verificationId = VerificationId
            completion(true)
        }
        
    }
    
    public func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        guard let verificationId = verificationId else {
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId,
            verificationCode: smsCode
        )
        
        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
