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
    var ProductsList = [Products] ()
    override func viewDidLoad() {
        super.viewDidLoad()
       // ref = Database.database().reference()
               fetchProduct ()
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
print(dictionary)
                let product = Products()
                product.ProductName = dictionary["ProductName"] as? String
                product.ProductImageURL = dictionary["ProductImageURL"] as? String
                product.Email = dictionary["OwnerEmail"] as? String
                product.RentalDuration = dictionary["RentalDuration"] as? String
               // product.setValuesForKeys(dictionary)
                self.ProductsList.append(product)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            }
        })


//        Database.database().reference().child("Products").observe(.childAdded, with: { (snapshot) in
//            if let dictionary = snapshot.value as? [String : AnyObject]{
//
//                                let product = Products()
//                             //   product.setValuesForKeys(dictionary)
//                product.ProductName = dictionary["ProductName"] as? String
//              }
//        }, withCancel: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ProductsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductsCell
       // let cell = ProductsCell()
        
       // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    let product = ProductsList[indexPath.row]
   cell.OwnerEmail.text = product.Email
   cell.ProductName.text = product.ProductName
     cell.RentalDuration.text = product.RentalDuration
        
     //   cell.RentalDuration.text = product.ProductImageURL
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
    }


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
