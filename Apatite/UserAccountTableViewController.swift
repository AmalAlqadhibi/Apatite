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
   // var userProfile = ["My orders","My producte", "My information","FAQ","Term & conditions -Privacy Policy", "Log out"]
    @IBOutlet weak var UserName: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isTranslucent = false
checkIfUserIsLogIn()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func checkIfUserIsLogIn(){
        if Auth.auth().currentUser?.uid == nil {
            // performSelector(#selector(handleLogout),withObject: nil, aferDelay: 0)}
            
        }
        else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with:{(snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    let Name = dictionary["username"] as? String
                    self.UserName.text = Name
                }}, withCancel: nil)}
        //        AccountImg?.setImage(string: "Amal Alqadhibi", color: .random, circular: true, textAttributes: [NSAttributedStringKey.font: UIFont(name: "Poppins-Light", size: 16) , NSAttributedStringKey.foregroundColor: UIColor.white])
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func logOut(_ sender: UIStoryboardSegue) {
        if Auth.auth().currentUser != nil {
            do {
                try  Auth.auth().signOut()
                   self.dismiss(animated: true, completion: nil)
             //   performSegue(withIdentifier: "unwindSegue1", sender: self)
               // self.performSegue(withIdentifier: "logOut", sender: nil)
//                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "logInAndJoin")
//                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
    
    // MARK: - Table view data source
    

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        // #warning Incomplete implementation, return the number of rows
//
//        return userProfile.count
//    }
    
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // print("You selected cell #\(indexPath.row)!")
//  //      print("You selected cell #\(indexPath.section)!")
//        if let staticIndexPath = tableView.indexPath(for: LogOut), staticIndexPath == indexPath {
//            let firebaseAuth = Auth.auth()
//                    do {
//                         try firebaseAuth.signOut()
//                      } catch let signOutError as NSError {
//                          print ("Error signing out: %@", signOutError)
//                       }
//            // ADD CODE HERE
//        }
//      //  if let staticIndexPath = tableView.indexPath(for: LogOut), staticIndexPath == indexPath {
//     //       let firebaseAuth = Auth.auth()
//    //        do {
//   //             try firebaseAuth.signOut()
//  //          } catch let signOutError as NSError {
//  //              print ("Error signing out: %@", signOutError)
// //           }
//
//            // ADD CODE HERE
//  //      }
//
//        print(indexPath.section)
//        print(indexPath.row)
//    }

 
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = userProfile [indexPath.row]
//
//
//
//
//        return cell
//    }
//

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
