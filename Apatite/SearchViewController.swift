//
//  SearchViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 02/04/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Foundation
import UIKit


class ProductsInSearch : NSObject {
    var ProductName: String?
    var ProductImageURL:String?
    var ProductBrand: String?
    var Size: String?
    var RentalPrice: String?
    
}

class searchProductsCell: UITableViewCell{
    
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productSize: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var ProductImageURL: UIImageView!
    
}



class SearchTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var SearchTableView: UITableView!
    
    var searchController = UISearchController(searchResultsController: nil)
    let resultsController = UITableViewController()
    var ProductsList = [ProductsInSearch] ()
    var filtered = [ProductsInSearch] ()
    var refHandle: UInt?
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProduct ()
        searchBar.delegate = self
        searchBar.setShowsCancelButton(true, animated: true)
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        tableView.tableFooterView = UIView()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Apatite logo view")
        self.view.insertSubview(backgroundImage, at: 6)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filtered = ProductsList.filter({ product -> Bool in
            if product.ProductName!.lowercased().contains(searchController.searchBar.text!){
                return true
            }else{
                return false
            }
        })
        tableView.reloadData()
        
    }
    
    
    func fetchProduct(){
        
        refHandle = Database.database().reference().child("Products").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]{
                let product = ProductsInSearch()
                product.ProductName = dictionary["ProductName"] as? String
                product.ProductImageURL = dictionary["ProductImageURL"] as? String
                product.ProductBrand = dictionary["ProductBrand"] as? String
                product.Size = dictionary["Size"] as? String
                product.RentalPrice = dictionary["RentalPrice"] as? String
                // product.setValuesForKeys(dictionary)
                self.ProductsList.append(product)
                //    DispatchQueue.main.async {
                //    self.tableView.reloadData()
                //    }
                self.filtered = self.ProductsList
            }})
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""{
            return filtered.count
        }
        return filtered.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCellInSearch") as? searchProductsCell else {
            return UITableViewCell()
        }
        
        cell.ProductName.text = filtered[indexPath.row].ProductName
        cell.productBrand.text = filtered[indexPath.row].ProductBrand
        cell.productSize.text = filtered[indexPath.row].Size
        cell.productPrice.text = filtered[indexPath.row].RentalPrice

        if let ProductImageURL = ProductsList[indexPath.row].ProductImageURL{
            let url = NSURL(string: ProductImageURL)
            let request = URLRequest(url:url! as URL)
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

                if error != nil {
                    print(error as Any)
                    return
                    
                }
                DispatchQueue.main.async {
                    cell.ProductImageURL?.image = UIImage(data:data!)
                }
            }).resume()
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filtered = ProductsList
            return
        }
        filtered = ProductsList.filter({ product -> Bool in
            product.ProductName!.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
        
    }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchController.isActive = true
        searchBar.text = nil

        
    }
    
    
}



