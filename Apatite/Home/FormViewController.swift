//
//  FormViewController.swift
//  Apatite
//
//  Created by Nada on 4/3/18.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class FormViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate,  UIImagePickerControllerDelegate {

   
    // Form
    
        @IBOutlet var images: [UILabel]!
        @IBOutlet weak var item: UITextField!
        @IBOutlet weak var size: UITextField!
        @IBOutlet weak var RetailPrice: UITextField!
        @IBOutlet weak var DurationofRent: UITextField!
        @IBOutlet weak var CurrentLocation: UITextField!
        @IBOutlet weak var City: UITextField!
        @IBOutlet weak var viewimage1: UIImageView!
        @IBOutlet weak var Switch: UISwitch!
        var email: String?
        var imagePicker = UIImagePickerController()
        var imagePicked = 0
        
        var selectedImage: UIImage?
        
        
        // select image
        var   image1 = UIImagePickerController()
        @IBAction func chooseimage(_ sender: AnyObject) {
            
            image1.delegate = self
            
            let actionSheet1 = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet )
            actionSheet1.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction ) in
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    self.image1.sourceType = .camera
                    
                    
                    self.present(self.image1, animated: true, completion: nil)
                }else{
                    print("Camera not available")
                }
            }))
            
            actionSheet1.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction ) in
                self.image1.sourceType = .photoLibrary
                
                self.present(self.image1, animated: true, completion: nil)
            }))
            
            actionSheet1.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil ))
            
            self.present(actionSheet1, animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            selectedImage = image
            viewimage1.image = image
            dismiss( animated: true, completion: nil)
            
        }
        
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss( animated: true, completion: nil)
        }
        
        
        // go to next field
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            if textField == item {
                textField.resignFirstResponder()
                size.becomeFirstResponder()
            } else if textField == size {
                textField.resignFirstResponder()
                RetailPrice.becomeFirstResponder()
            } else if textField == RetailPrice {
                textField.resignFirstResponder()
                DurationofRent.becomeFirstResponder()
            } else  if textField == DurationofRent {
                textField.resignFirstResponder()
                CurrentLocation.becomeFirstResponder()
            } else if textField == CurrentLocation {
                textField.resignFirstResponder()
                City.becomeFirstResponder()
            }else{
                view.endEditing(true)
            }
            return true
        }
        
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
        
        @IBAction func cancel(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
        
        
        // if complete information send data
        
        @IBAction func send(_ sender: Any) {
            if self.item.text == "" || self.size.text == "" || self.RetailPrice.text == "" || self.DurationofRent.text == "" || self.CurrentLocation.text == "" || self.City.text == "" || self.viewimage1.image == nil
            {
                
                let alertController = UIAlertController(title: "Error", message: "Please complete information.", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
                
            } else if Switch.isOn {
                //send data
                
                let uid = Auth.auth().currentUser?.uid
                Database.database().reference().child("users").child(uid!).observe(.value, with:{(snapshot) in
                    if let dictionary = snapshot.value as? [String: AnyObject]{
                        self.email = dictionary["email"] as! String
                    }}, withCancel: nil)
                let storageRef = Storage.storage().reference(forURL: "gs://apatite-d2551.appspot.com/").child("requests_image").child(uid!)
                let newStorage = storageRef.child(uid!)
                if let viewimage = selectedImage, let imageData = UIImageJPEGRepresentation(viewimage, 0.1){
                    storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                        if error != nil{
                            return
                        }
                        let viewimageUrl = metadata?.downloadURL()?.absoluteString
                        
                        let ref = Database.database().reference().child("Requests")
                        
                        let newproduct = ref.child(uid!)
                        
                        newproduct.setValue([
                            "id": uid!,
                            "product": self.item.text!,
                            "Size": self.size.text!,
                            "Retail Price": self.RetailPrice.text!,
                            "Duration of Rent": self.DurationofRent.text!,
                            "Current Location":  self.CurrentLocation.text!,
                            "City": self.City.text!,
                            "Product image URL": viewimageUrl,
                            "OwnerEmail":self.email!
                            ])
                    })
                }
                
                //message
                
                let alert = UIAlertView(title: "Thank you",
                                        message: "Your order has been sent, We will send to you a message to your email in a week!",
                                        delegate: nil,
                                        cancelButtonTitle: "Ok")
                alert.show()
                // go to back cancel
                self.dismiss(animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Error", message: "You should must agree to the terms and Condition & Privacy Policy.", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
                present(alertController, animated: true, completion: nil)
            }
        }
        
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

}

