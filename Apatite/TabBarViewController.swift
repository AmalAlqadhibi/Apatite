//
//  TabBarViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 01/04/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
   //     let tabBarController = UITabBarController()
        
     //   Auth.auth().addStateDidChangeListener { (auth, user) in if user != nil {
     //         let userAccountTableViewController = UserAccountTableViewController()
            
//                userAccountTableViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Account"), tag: 3)
                // user is signed in
                //    performSegue(withIdentifier: "UserLogIn", sender: self)
        
 
        //     self.setViewControllers([userAccountTableViewController], animated: true)
                
         //   }
          //  else {
//            let accountNotLogInViewController = AccountNotLogInViewController()
//            accountNotLogInViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Account"), tag: 3)
//                //      performSegue(withIdentifier: "NotLogIn", sender: self)
//            }
        
     
//        }

        
        
       
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
