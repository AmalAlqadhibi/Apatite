//
//  UserAccountTableViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 26/03/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class UserAccountTableViewController: UITableViewController {
    @IBOutlet weak var UserName: UILabel!
 @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.checkIfUserIsLogIn()
    }
    
    func checkIfUserIsLogIn(){
        if Auth.auth().currentUser?.uid == nil {
//         performSelector(#selector(logOut),withObject: nil, aferDelay: 0)
        }
        else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with:{(snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    let Name = dictionary["username"] as! String
                      self.UserName.text = Name  
                }}, withCancel: nil)}
    }

    @IBAction func logOut(_ sender: UIStoryboardSegue) {
        if Auth.auth().currentUser != nil {
            do {
                try  Auth.auth().signOut()
                   self.dismiss(animated: true, completion: nil)
             //   performSegue(withIdentifier: "unwindSegue1", sender: self)
               // self.performSegue(withIdentifier: "logOut", sender: nil)
               let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "logInAndJoin")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
