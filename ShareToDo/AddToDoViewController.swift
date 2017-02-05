//
//  AddToDoViewController.swift
//  ShareToDo
//
//  Created by George Davies on 05/02/2017.
//  Copyright © 2017 George Davies. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {

    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var toDoTextField: UITextField!
    
    var toDo = [ToDo]()
    
    @IBAction func saveToDo(_ sender: UIButton) {
        let toDoRecipient = toTextField.text
        let toDoText = toDoTextField.text
        
        let toDoObject = ToDo(recipient: toDoRecipient!,sender: "",toDoText: toDoText!)
        toDo.append(toDoObject)
        for tos in toDo {
            print(tos.recipient)
            print(tos.toDoText)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
