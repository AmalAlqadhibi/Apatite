//
//  LoginViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 17/03/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
class LoginViewController: UIViewController {

    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        Password.setBorder()
        Email.setBorder()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Cancel button
    @IBAction func cancelOnClick(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
    }
     // hide the keyboard when user touch the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    @IBAction func loginAction(_ sender: Any) {
 let ref = Database.database().reference()
        //check if the textfield empty
        if self.Email.text == nil || self.Password.text == nil {
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields
            
            let alertController = UIAlertController(title: "Oops!", message: "Please enter your Email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: self.Email.text!, password: self.Password.text!) { (user, error) in
                if error == nil {
                      let uid = user?.uid
                    Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with:{(snapshot) in
                        if let dictionary = snapshot.value as? [String: AnyObject] {
                            let accountType = dictionary["accountType"] as! String
                            if  accountType == "User"{
                                self.performSegue(withIdentifier: "UserAccount", sender: nil)
                            } else{
                                  self.performSegue(withIdentifier: "Admin", sender: nil)
                            }
                        }}, withCancel: nil)
                    print("You have successfully logged in")
                }
                else {
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
