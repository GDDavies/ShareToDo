//
//  SignUpViewController.swift
//  ShareToDo
//
//  Created by George Davies on 04/02/2017.
//  Copyright © 2017 George Davies. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSignUp(_ sender: UIButton) {
        guard let name = nameField.text,
            let email = emailField.text,
            let password = passwordField.text,
            name.characters.count > 0,
            email.characters.count > 0,
            password.characters.count > 0
            else {
                self.showAlert(message: "Enter a name, an email and a password.")
                return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                if error._code == FIRAuthErrorCode.errorCodeInvalidEmail.rawValue {
                    self.showAlert(message: "Enter a valid email.")
                } else if error._code == FIRAuthErrorCode.errorCodeEmailAlreadyInUse.rawValue {
                    self.showAlert(message: "Email already in use.")
                } else {
                    self.showAlert(message: "Error: \(error.localizedDescription)")
                }
                print(error.localizedDescription)
                return
            }
            
            if let user = user {
                self.setUserName(user: user, name: name)
            }
        }
    }

    func setUserName(user: FIRUser, name: String) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = name
        
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            AuthenticationManager.sharedInstance.didLogIn(user: user)
            self.performSegue(withIdentifier: "ShowToDoList", sender: nil)
        }
    }
    
    func showAlert(message: String) {
        // create the alert
        let alert = UIAlertController(title: "ShareToDo", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

}
