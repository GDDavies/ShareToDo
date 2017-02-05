//
//  ViewController.swift
//  ShareToDo
//
//  Created by George Davies on 04/02/2017.
//  Copyright © 2017 George Davies. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailField.text = "g@g.com"
        passwordField.text = "123456"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapLogin(_ sender: UIButton) {
        guard let email = emailField.text,
            let password = passwordField.text,
            email.characters.count > 0,
            password.characters.count > 0 else {
                self.showAlert(message: "Enter an email and a password.")
                return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                if error._code == FIRAuthErrorCode.errorCodeUserNotFound.rawValue {
                    self.showAlert(message: "There are no users with the specified account.")
                } else if error._code == FIRAuthErrorCode.errorCodeWrongPassword.rawValue {
                    self.showAlert(message: "Incorrect username or password.")
                } else {
                    self.showAlert(message: "Error: \(error.localizedDescription)")
                }
                print(error.localizedDescription)
                return
            }
            
            if let user = user {
                AuthenticationManager.sharedInstance.didLogIn(user: user)
                self.performSegue(withIdentifier: "ShowToDosFromLogin", sender: nil)
            }
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

