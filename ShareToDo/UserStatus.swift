//
//  UserStatus.swift
//  iChatBaaS4.7
//
//  Created by George Davies on 17/10/2016.
//  Copyright © 2016 George Davies. All rights reserved.
//

import Foundation

class UserStatus: NSObject {
    
    static let sharedInstance = UserStatus()
    
    var signedIn = false
    var displayName: String?
    var userId: String?
}