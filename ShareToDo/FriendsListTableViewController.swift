//
//  FriendsListTableViewController.swift
//  ShareToDo
//
//  Created by George Davies on 06/02/2017.
//  Copyright © 2017 George Davies. All rights reserved.
//

import UIKit
import Firebase

class FriendsListTableViewController: UITableViewController {
    
    var ref: FIRDatabaseReference!
    
    var friends = [Friend]()
    var selectedFriends = [String]()
    var userID: String?
    
    @IBAction func logOut(sender: UIBarButtonItem) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            AuthenticationManager.sharedInstance.loggedIn = false
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError)")
        }
    }

    @IBAction func addFriend(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationItem.title = "All Users"
        getFriends()
    }

    func getFriends() {
        
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let friend = Friend()
                friend.setValuesForKeys(dictionary)
                
                let currentFriend = FIRAuth.auth()?.currentUser
                let currentFriendEmail = currentFriend?.email
                
                if friend.email != currentFriendEmail {
                    self.friends.append(friend)
                }
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "UserCell")
        
        let user = friends[indexPath.row]
        cell.textLabel?.text = user.email
        
        let userIndex = selectedFriends.index(where: {$0 == friends[indexPath.row] as AnyHashable})
        
        if userIndex != nil {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if (cell?.accessoryType == UITableViewCellAccessoryType.checkmark){
            cell!.accessoryType = UITableViewCellAccessoryType.none;
            if let indexOfComponent = selectedFriends.index(where: {$0 == friends[indexPath.row].uid!}){
                selectedFriends.remove(at: indexOfComponent)
            }
        }else{
            selectedFriends.append(friends[indexPath.row].uid!)
            cell!.accessoryType = UITableViewCellAccessoryType.checkmark;
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowMessages" {
//            if let destinationVC = segue.destination as? ChatViewController {
//                destinationVC.selectedUsers = selectedFriends
//                destinationVC.userID = userID
//            }
//        }
//        
//        if segue.identifier == "SignOut" {
//            let firebaseAuth = FIRAuth.auth()
//            do {
//                try firebaseAuth?.signOut()
//                UserStatus.sharedInstance.signedIn = false
//            } catch let signOutError as NSError {
//                print ("Error signing out: \(signOutError)")
//            }
//        }
//    }


}
