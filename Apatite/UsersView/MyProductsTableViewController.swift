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
    
    @IBOutlet var NoProduct: UIView!
    var email: String?
    var ProductsList = [Products] ()
    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
        super.viewDidLoad()
        fetchProduct ()
        tableView.tableFooterView = UIView()
    }
    func calculatReturnDate(product:Products) {
        //let product = Products()
        let RentalDuration = product.RentalDuration ?? "0"
        if let textInt = Int(RentalDuration) {
            //Add Rental Duration to current date to calculate Return Date
            let ReturnDate = Calendar.current.date(byAdding: .day, value: textInt, to: Date())
            //set gregorian calender
            let greg = Calendar(identifier: .gregorian)
            let todayDate = Date()
            // calculate the duration betwwen today and return date
            let components1 = greg.dateComponents([.year, .month, .day], from: ReturnDate!)
            let components2 = greg.dateComponents([.year, .month, .day], from: todayDate)
            let weeksAndDays = greg.dateComponents([.year ,.weekOfMonth, .day], from: components2, to: components1)
            let ReturnMess = "The product will be return to user in: \(weeksAndDays.year!) Year, \(weeksAndDays.weekOfMonth!) week, \(weeksAndDays.day!) day."
            product.ReturnMess = ReturnMess
        }
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
                            product.ProductImageURL = dictionary["ProductImageURL"] as? String
                            // calculate return date
                            self.calculatReturnDate(product: product)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        var numOfSection: NSInteger = 0
        if ProductsList.count > 0 {
            self.tableView.backgroundView = nil
            self.tableView.separatorStyle = .singleLine
            numOfSection = 1
        } else {
            tableView.backgroundView = NoProduct
        }
        return numOfSection
    }
    
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
        cell.ReturnMess.text = product.ReturnMess
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
    }}

