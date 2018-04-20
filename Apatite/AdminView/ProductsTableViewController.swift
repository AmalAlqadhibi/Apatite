//
//  ProductsTableViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 04/04/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class ProductsTableViewController: UITableViewController {
    var refHandle: UInt?
    var ref: DatabaseReference!
    //var keyArray:[String] = []
    var keyArray = [String] ()
    var ProductsList = [Products] ()
    override func viewDidLoad() {
        super.viewDidLoad()
       // ref = Database.database().reference()
               fetchProduct ()
        tableView.allowsMultipleSelectionDuringEditing = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    //Cancel button
    @IBAction func cancelOnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func fetchProduct (){
        refHandle = Database.database().reference().child("Products").observe(.childAdded, with: { (snapshot) in 
            if let dictionary = snapshot.value as? [String : AnyObject]{
                let product = Products()
                product.ProductName = dictionary["ProductName"] as? String
                product.ProductImageURL = dictionary["ProductImageURL"] as? String
                product.Email = dictionary["OwnerEmail"] as? String
                product.RentalDuration = dictionary["RentalDuration"] as? String
               // product.setValuesForKeys(dictionary)
                self.ProductsList.append(product)
                product.ProductID = snapshot.key
                self.keyArray.append( product.ProductID!)
                self.tableView.reloadData()
                self.ref?.keepSynced(true)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
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
//    func store(ProductID: String ,product: Products) {
//
//      let ref = Database.database().reference().child("Products")
//
//        let refHandle = ref.childByAutoId()
//        product.ProductID = ref.key
//        }
//
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let product = ProductsList[indexPath.row]
//            groceryItem.ref?.removeValue()
//        }
//    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print(indexPath.row)
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductsCell
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
