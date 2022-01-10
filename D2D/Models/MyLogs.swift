//
//  logs.swift
//  D2D
//
//  Created by Ahmed Eldably on 10.01.22.
//

import Foundation

class MyLogs {
    static var numberOfLoginAttempts = 0

    init() {}

    func loginAttempt() -> Int {
        MyLogs.numberOfLoginAttempts += 1
        return MyLogs.numberOfLoginAttempts
    }

}
