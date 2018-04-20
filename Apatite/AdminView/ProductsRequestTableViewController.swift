//
//  ProductsRequestTableViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 12/04/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//
import UIKit
import Firebase
import FirebaseDatabase

class ProductsRequestTableViewController: UITableViewController {
    var keyArray = [String] ()
      var ref: DatabaseReference!
    var ProductsList = [Products] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
fetchRequests()
        tableView.allowsMultipleSelectionDuringEditing = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Cancel button
    @IBAction func cancelOnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
 

    func fetchRequests (){
        
       let refHandle = Database.database().reference().child("Requests").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]{
                let product = Products()
                print(snapshot)
                product.ProductName = dictionary["product"] as? String
                product.ProductImageURL = dictionary["Product image URL"] as? String
                product.Email = dictionary["OwnerEmail"] as? String
                product.RentalDuration = dictionary["Duration of Rent"] as? String
                product.RentalPrice = dictionary["Retail Price"] as? String
                // product.setValuesForKeys(dictionary)
                self.ProductsList.append(product)
               product.ProductID = snapshot.key
                self.keyArray.append( product.ProductID!)
                self.tableView.reloadData()
                self.ref?.keepSynced(true)
                 print(snapshot)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // getAllKey()
           
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when, execute: {
                let ref = Database.database().reference()
                ref.child("Products").child(self.keyArray[indexPath.row]).removeValue()
                self.ProductsList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                self.keyArray.remove(at: indexPath.row)
                tableView.reloadData()

            })

        }}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ProductsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Request") as! Request
        let product = ProductsList[indexPath.row]
        cell.OwnerEmail.text = product.Email
        cell.ProductName.text = product.ProductName
        cell.RentalDuration.text = product.RentalDuration
        
        if let ProductImageURL = product.ProductImageURL{
            let imageStorageRef = Storage.storage().reference(forURL:ProductImageURL)
            imageStorageRef.getData(maxSize: 2*1024*1024, completion:{ [weak self](data,error)in
                if  error != nil {
                    print(error)
                }else{
                    DispatchQueue.main.async {
                        cell.ProductImage?.image = UIImage(data:data!)
                    }
                }
            })//.resume()
        }
        return cell
    }
}
