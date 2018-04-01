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

        //check if the textfield empty
        if self.Email.text == "" || self.Password.text == "" {
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: self.Email.text!, password: self.Password.text!) { (user, error) in
                if error == nil {
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                 self.performSegue(withIdentifier: "UserAccount", sender: nil)
                    //Go to the HomeViewController if the login is sucessful
                 //  let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserAccount")
                 
               //   self.present(vc!, animated: true, completion: nil)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
