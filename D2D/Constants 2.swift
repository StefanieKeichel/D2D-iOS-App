//
//  Constants.swift
//  D2D
//
//  Created by Ahmed Eldably on 10.11.21.
//

import Foundation

struct Constants {
    static let cellNibName = "MessageCell"
    static let appName = "D2D Communication"
    static let cellIdentifier = "ReusableCell"
    
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
