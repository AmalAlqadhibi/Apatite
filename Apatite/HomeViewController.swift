//
//  HomeViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 02/04/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class HomeViewController: UIViewController {

    
        
        
        @IBAction func RentFormButton(_ sender: Any) {
            
            Auth.auth().addStateDidChangeListener { auth, user in
                if Auth.auth().currentUser != nil {
                    self.performSegue(withIdentifier: "showform", sender: nil)
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: "please create account", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
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
