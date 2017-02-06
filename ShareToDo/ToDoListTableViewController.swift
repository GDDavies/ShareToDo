//
//  ToDoListTableViewController.swift
//  ShareToDo
//
//  Created by George Davies on 04/02/2017.
//  Copyright © 2017 George Davies. All rights reserved.
//

import UIKit
import Firebase

class ToDoListTableViewController: UITableViewController {
    
    var toDoList = [ToDo]()
    //var toDoList = ["This","That","Other"]
    var ref: FIRDatabaseReference!
    private var databaseHandle: FIRDatabaseHandle!
    var senderId: String?
    var recipientName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        senderId = AuthenticationManager.sharedInstance.userId
        
        ref = FIRDatabase.database().reference(fromURL: "https://sharetodo-2bbee.firebaseio.com/")
        setupData()
    }
    
    func setupData() {
        databaseHandle = ref.child("todos").queryOrdered(byChild: "recipientName").observe(.childAdded, with: { (snapshot) -> Void in
        //databaseHandle = ref.child("todos").observe(.childAdded, with: { (snapshot) -> Void in
            if let value = snapshot.value as? [String:AnyObject] {
                let id = value["senderId"] as! String
                let text = value["text"] as! String
                let recipient = value["recipientName"] as! String
                
                let toDoObject = ToDo(recipient: recipient,sender: id,toDoText: text)
                
                if recipient == "George" {
                    self.toDoList.append(toDoObject)
                    self.tableView.reloadData()
                } else {
                    // do nothing
                }
                
                //self.addToDo(id: id, text: text, recipient: recipient)
                //self.finishReceivingMessage()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = toDoList[indexPath.row].toDoText

        return cell
    }
    
    func addToDo(id: String, text: String, recipient: String) {
        let toDoObject = ToDo(recipient: recipient,sender: id,toDoText: text)
        toDoList.append(toDoObject)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.ref.removeObserver(withHandle: databaseHandle)
    }
    
    func setData() {
        let toDoRef = ref.child("todos").childByAutoId()
        let todo = [
            "text": "test todo",
            "senderId": senderId!,
            "recipientName": "George" //recipientName!
        ]
        toDoRef.setValue(todo)
    }

}
