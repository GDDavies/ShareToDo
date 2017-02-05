//
//  ToDo.swift
//  ShareToDo
//
//  Created by George Davies on 05/02/2017.
//  Copyright © 2017 George Davies. All rights reserved.
//

import Foundation

class ToDo: NSObject {
    var recipient: String
    var sender: String
    var toDoText: String
    
    init(recipient: String, sender: String, toDoText: String) {
        self.recipient = recipient
        self.sender = sender
        self.toDoText = toDoText
    }
}
