//
//  AddNewAdminViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 02/04/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AddNewAdminViewController: UIViewController {
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isTranslucent = false;
        super.viewDidLoad()
Name.setBorder()
        Password.setBorder()
        Email.setBorder()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelOnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddNewAction(_ sender: Any) {
        if Email.text == nil || Password == nil{
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: Email.text!, password: Password.text!, completion: { (user: User?, error: Error?) in
                if error != nil {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    print(error!.localizedDescription)
                    return
                }
                else{
                    let info = ["accountType": "Admin","username": self.Name.text! , "email": self.Email.text! ]
                    let uid = user?.uid
                    let ref = Database.database().reference()
                    ref.child("users").child(uid!).setValue(info)
                       self.dismiss(animated: true, completion: nil)
                }
       })}
        }

}
