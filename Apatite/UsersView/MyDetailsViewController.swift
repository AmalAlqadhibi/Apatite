//
//  MyDetailsViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 15/04/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class MyDetailsViewController: UIViewController {

    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var PhoneNumber: UITextField!
    @IBOutlet weak var Address1: UITextField!
    @IBOutlet weak var Address2: UITextField!
    @IBOutlet weak var City: UITextField!
     var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.setBorder()
        Email.setBorder()
        PhoneNumber.setBorder()
        Address1.setBorder()
        Address2.setBorder()
        City.setBorder()
        fetchUserInfo()
    }
   func fetchUserInfo(){
     let uid = Auth.auth().currentUser?.uid
    if uid != nil { Database.database().reference().child("users").child(uid!).observe(.value, with:{(snapshot) in
        if let dictionary = snapshot.value as? [String: AnyObject]{
    self.Name.text = dictionary["username"] as? String
            print(snapshot)
            self.Email.text = dictionary["email"] as? String
               self.PhoneNumber.text = dictionary["phoneNumber"] as? String
            self.Address1.text = dictionary["Address1"] as? String
            self.Address2.text = dictionary["Address2"] as? String
            self.City.text = dictionary["city"] as? String
     }}, withCancel: nil)
    }
    }
    
    @IBAction func UpdateuserProfile(_ sender: Any) {
        let uid = Auth.auth().currentUser?.uid
        if Email.text == nil  {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter your Email", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else {
            let info = ["accountType": "User","username": self.Name.text! , "email": self.Email.text!,"phoneNumber": self.PhoneNumber.text!,"Address1": self.Address1.text!,"Address2": self.Address2.text!,"city": self.City.text! ]
            
            
            Auth.auth().currentUser?.updateEmail(to: self.Email.text!) { (error) in
                if error == nil{
                    let uid = Auth.auth().currentUser?.uid
                    Database.database().reference().child("users").child(uid!).observe(.value, with:{(snapshot) in
                        if let dictionary = snapshot.value as? [String: AnyObject]{
                            self.email = dictionary["email"] as! String
                            
                            let ref = Database.database().reference().child("Products")
                            let refHandle = ref.queryOrdered(byChild: "OwnerEmail").queryEqual(toValue: self.email).observeSingleEvent(of:.value, with: { (snapshot) in
                                for childSnapshot in snapshot.children {
                                    let child = childSnapshot as? DataSnapshot
                                 ref.setValue(["OwnerEmail": self.email])
                                 }
                            })
                        }}, withCancel: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Oops!", message: "We can not update your Email \(error?.localizedDescription ?? "")", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)

                    
                }
            }

            Database.database().reference().child("users").child(uid!).setValue(info)
             self.dismiss(animated: true, completion: nil)
            
        }
    }
}
