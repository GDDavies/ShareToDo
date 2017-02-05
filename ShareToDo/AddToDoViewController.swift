//
//  AddToDoViewController.swift
//  ShareToDo
//
//  Created by George Davies on 05/02/2017.
//  Copyright © 2017 George Davies. All rights reserved.
//

import UIKit
import Firebase

class AddToDoViewController: UIViewController {

    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var toDoTextField: UITextField!
    
    var ref: FIRDatabaseReference!
    var senderId: String?
    var recipientName: String?
    
    @IBAction func saveToDo(_ sender: UIButton) {
        let toDoRecipient = toTextField.text
        let toDoText = toDoTextField.text
        
        let toDoObject = ToDo(recipient: toDoRecipient!,sender: senderId!,toDoText: toDoText!)
        
        let toDoRef = ref.child("todos").childByAutoId()
        let todo = [
            "text": toDoObject.toDoText,
            "senderId": toDoObject.sender,
            "recipientName": toDoObject.recipient //recipientName!
        ]
        toDoRef.setValue(todo)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAddToDo(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        senderId = AuthenticationManager.sharedInstance.userId
        
        ref = FIRDatabase.database().reference(fromURL: "https://sharetodo-2bbee.firebaseio.com/")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
