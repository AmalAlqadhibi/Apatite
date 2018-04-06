//
//  AddNewProductViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 03/04/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
class AddNewProductViewController: UIViewController {
    
    @IBOutlet weak var RentalPrice: UITextField!
    @IBOutlet weak var ProductBrand: UITextField!
    @IBOutlet weak var Size: UITextField!
    @IBOutlet weak var RentalDuration: UITextField!
    @IBOutlet weak var ProductName: UITextField!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var OwnerEmail: UITextField!
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        RentalPrice.setBorder()
        ProductBrand.setBorder()
        ProductName.setBorder()
        Size.setBorder()
        RentalDuration.setBorder()
        ProductName.setBorder()
        OwnerEmail.setBorder()
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(AddNewProductViewController.handleSelectProductImageView))
        productImage.addGestureRecognizer(tapGesture)
        productImage.isUserInteractionEnabled = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func AddProduct(_ sender: Any) {
        let uid = Auth.auth().currentUser?.uid
    let storageRef = Storage.storage().reference(forURL: "gs://apatite-d2551.appspot.com/").child("product_image").child(uid!)
        let newStorage = storageRef.child(uid!)
        if let viewimage = selectedImage, let imageData = UIImageJPEGRepresentation(viewimage, 0.1){
            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    return
                }
                let viewimageUrl = metadata?.downloadURL()?.absoluteString
                let ref = Database.database().reference().child("Products").childByAutoId()
                ref.setValue(["ProductName":self.ProductName.text,"OwnerEmail":self.OwnerEmail.text,"ProductBrand":self.ProductBrand.text,"Size":self.Size.text,"RentalDuration":self.RentalDuration.text,"RentalPrice":self.RentalPrice.text,"ProductImageURL": viewimageUrl])
            })
        }
         self.dismiss(animated: true, completion: nil)
        
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
    @objc func handleSelectProductImageView() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
}
extension AddNewProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("did Finish Picking Media")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImage = image
            productImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
