//
//  MyProductsTableViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 05/04/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
class MyProductsTableViewController: UITableViewController {
    var email: String?
      var ProductsList = [Products] ()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProduct ()
    }
    func fetchProduct (){
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observe(.value, with:{(snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                self.email = dictionary["email"] as! String
                let ref = Database.database().reference().child("Products")
                let refHandle = ref.queryOrdered(byChild: "OwnerEmail").queryEqual(toValue: self.email).observeSingleEvent(of:.value, with: { (snapshot) in
                  
                   
                    for childSnapshot in snapshot.children {
                     let child = childSnapshot as? DataSnapshot
                        if let dictionary = child?.value as? [String : AnyObject] {
                            let product = Products()
                            
                            product.ProductName = dictionary["ProductName"] as? String
                            product.RentalDuration = dictionary["RentalDuration"] as? String
                            product.DateOfAdd = dictionary["DateOfAdd"] as? String
                            product.ProductImageURL = dictionary["ProductImageURL"] as? String
                         
                            self.ProductsList.append(product)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }}
                })
            }}, withCancel: nil)
    }
    //Cancel button
    @IBAction func cancelOnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return ProductsList.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ProductsList.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyProductsCell") as! MyProductsCell
        // let cell = ProductsCell()
        // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let product = ProductsList[indexPath.row]
        cell.ProductName.text = product.ProductName
        cell.RentalDuration.text = product.RentalDuration
         cell.DateOfAdd.text = product.DateOfAdd
        if let ProductImageURL = product.ProductImageURL{
            let url = NSURL(string: ProductImageURL)
            // print(url!)
            let request = URLRequest(url:url! as URL)
            // let url = URLRequest(url: ProductImageURL)
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                //download hit error
                if error != nil {
                    print(error)
                    return
                }
                DispatchQueue.main.async {
                    cell.ProductImage?.image = UIImage(data:data!)
                }
            }).resume()
        }
        
        return cell
    }}

