//
//  UserAccountViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 20/03/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class UserAccountViewController: UIViewController {
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var AccountImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLogIn()
     // let name = dictionary["username"] as? String
//        AccountImg?.setImage(string: name, color: .random, circular: true, attributes: [NSAttributedStringKey.font: UIFont(name: "Poppins-Light", size: 16) , NSAttributedStringKey.foregroundColor: UIColor.softBlue])
       // AccountImg.layer.cornerRadius = AccountImg.frame.size.width/2
      //  AccountImg.clipsToBounds = true
        

        // Do any additional setup after loading the view. Poppins-Light
    }
   
   
//    let ref = DatabaseReference.init()
//    func getName(userUID:String) {
//        self.ref = Database.database().reference()
//        self.ref.child("users").child(<#T##pathString: String##String#>)
//    }
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
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
