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
//        let homeViewController = HomeViewController()
//        homeViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Apatite logo"), tag: 0)
//        let searchViewController = SearchViewController()
//        searchViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Search "), tag: 1)
//        let addToBagViewController = AddToBagViewController()
//        addToBagViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Add2Bag"), tag: 2)
//
//
//   //     let tabBarController = UITabBarController()
//
//        Auth.auth().addStateDidChangeListener { (auth, user) in if user != nil {
//
//
//              //  let userAccountTableViewController = UserAccountTableViewController() logInAndJoin
//            guard var userAccountTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserLogIn") else
//            {
//                return
//            }
//            userAccountTableViewController = UserAccountTableViewController()
//            userAccountTableViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Account"), tag: 3)
//            let viewControllerList = [ homeViewController, searchViewController, addToBagViewController, userAccountTableViewController]
//            self.viewControllers = viewControllerList
//
//        } else {
//            guard var accountNotLogInViewController = self.storyboard?.instantiateViewController(withIdentifier: "logInAndJoin") else
//            {
//                return
//            }
//             accountNotLogInViewController = AccountNotLogInViewController()
//                        accountNotLogInViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Account"), tag: 3)
//            self.setViewControllers([homeViewController, searchViewController,addToBagViewController, accountNotLogInViewController], animated: true)
//           // let viewControllerList = [ homeViewController, searchViewController, addToBagViewController, accountNotLogInViewController]
//          //  self.viewControllers = viewControllerList
//            }
    
//}
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
