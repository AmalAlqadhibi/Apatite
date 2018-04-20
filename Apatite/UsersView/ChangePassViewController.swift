//
//  ChangePassViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 18/04/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ChangePassViewController: UIViewController {
    @IBOutlet weak var CurrentPass: UITextField!
    @IBOutlet weak var NewPass: UITextField!
    
    @IBOutlet weak var ConfNewPass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
CurrentPass.setBorder()
        NewPass.setBorder()
        ConfNewPass.setBorder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func UpdatePass(_ sender: Any) {
        let user = Auth.auth().currentUser
        //var credential: AuthCredential
        if let user = user {
            let email = user.email
            let credential = EmailAuthProvider.credential(withEmail: email!, password: self.CurrentPass.text!)
            user.reauthenticate(with: credential, completion: { (error) in
                if error != nil
                {
                    let alertController = UIAlertController(title: "Oops!", message: "Make sure you are write a currect current password", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                else
                {
                    if self.NewPass.text == self.ConfNewPass.text{
                        Auth.auth().currentUser?.updatePassword(to: self.NewPass.text!) { (error) in
                            print(error)
                             self.dismiss(animated: true, completion: nil)
                        }
                        
                    }
                    else {
                        let alertController = UIAlertController(title: "Oops!", message: "Please make sure you are write currect password and confirm a new currectly.", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                }
            })
        }
        //prompt user to re-enter info
        
    }

}
