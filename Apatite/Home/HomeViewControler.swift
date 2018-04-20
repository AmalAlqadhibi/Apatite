//
//  HomeViewController.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 02/04/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class HomeViewController: UIViewController, UICollectionViewDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var cellIdentifier = "cellProducts"
    var refHandle: UInt?
    var ProductsList = [Products] ()
    
    
    //@IBOutlet weak var usersCollectionView: UICollectionView!
    @IBOutlet weak var Collectionview: UICollectionView!
    //  Rent Form Button
    @IBAction func RentFormButton(_ sender: Any) {
        
        Auth.auth().addStateDidChangeListener { auth, user in
            
            if user != nil {
                
                self.performSegue(withIdentifier: "showform", sender: nil)
                
            } else {
                
                let alert = UIAlertController(title: "Sorry", message:"You have to Register First", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in })
                self.present(alert, animated: true){}
                
            }
        }
    }
    
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func fetchUser() {
        
        refHandle =  Database.database().reference().child("Products").observe(DataEventType.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let product = Products ()
                
                product.ProductImageURL = dictionary["ProductImageURL"] as? String
                product.ProductName = dictionary["ProductName"] as? String
                product.RentalPrice = dictionary["RentalPrice"] as? String
                self.ProductsList.append(product)
                
                DispatchQueue.main.async(execute: {
                    self.Collectionview.reloadData()             }
                )
                
                
            }
            
            print(snapshot)
            
        }, withCancel: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return  ProductsList.count
    }
    
    func collectionView(_ collectionView : UICollectionView,layoutcollectionView : UICollectionViewLayout, sizeForItemAT indexPath: IndexPath)->CGSize {
        return CGSize (width: self.view.frame.size.width / 2, height: self.view.frame.size.width / 2)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HomeProductsCell
        
        let cellProducts = ProductsList[indexPath.item]
        
        //cell.users = users[indexPath.item]
        
        cell.RentalPrice.text = cellProducts.RentalPrice
        cell.ProductName.text = cellProducts.ProductName
        if let ProductImageURL = cellProducts.ProductImageURL {
            
            cell.ProductImageURL.loadImageUsingCacheWithUrlString(urlString: ProductImageURL)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let information = ProductsList[indexPath.row]
        performSegue(withIdentifier: "showproductView", sender: information)
        
    }
    //    public func numberOfSections(in collectionView: UICollectionView) -> Int
    //    {
    //        return 1
    //    }
}

////////////////////////////////////////////////////////////////////////////////////////
//
//    var filtered:[String] = []
//
//    var refHandle: UInt?
//    var ref: DatabaseReference!
//    //var ProductsList = [ProductsInHome] ()
//
//  var ProductsList = [Products] ()
//
//    @IBOutlet weak var Collectionview: UICollectionView!
//
//
//    //Rent Form Button
//    @IBAction func RentFormButton(_ sender: Any) {
//
//        Auth.auth().addStateDidChangeListener { auth, user in
//
//            if user != nil {
//
//                self.performSegue(withIdentifier: "showform", sender: nil)
//
//            } else {
//
//                let alert = UIAlertController(title: "Sorry", message:"You have to Register First", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in })
//                self.present(alert, animated: true){}
//
//            }
//        }
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return ProductsList.count
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.frame.size.width/2, height: self.view.frame.size.width/2)
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProductCell", for: indexPath ) as! HomeProductsCell
//
//        let product = ProductsList [indexPath.row]
//     //   cell.ProductName.text = product.ProductName
//        cell.productBrand.text = product.ProductBrand
//      //  cell.productSize.text = product.Size
//        cell.productPrice.text = product.ProductPrice
//
//        //   cell.RentalDuration.text = product.ProductImageURL
//        if let ProductImageURL = product.ProductImageURL{
//            let url = NSURL(string: ProductImageURL)
//            // print(url!)
//            let request = URLRequest(url:url! as URL)
//            // let url = URLRequest(url: ProductImageURL)
//            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//                //download hit error
//                if error != nil {
//                    print(error)
//                    return
//                }
//                DispatchQueue.main.async {
//                    cell.ProductImageURL?.image = UIImage(data:data!)
//                }
//            }).resume()
//        }
//
//        return cell
//    }
//
//
//
//    func fetchProduct (){
//        refHandle = Database.database().reference().child("Products").observe(.childAdded, with: { (snapshot) in
//            if let dictionary = snapshot.value as? [String : AnyObject]{
//
//                let product = Products ()
//                product.ProductName = dictionary["ProductName"] as? String
//                product.ProductImageURL = dictionary["ProductImageURL"] as? String
//                product.ProductBrand = dictionary["ProductBrand"] as? String
//               // product.Size = dictionary["Size"] as? String
//                product.ProductPrice = dictionary["RentalPrice"] as? String
//
//                // product.setValuesForKeys(dictionary)
//                self.ProductsList.append(product)
//                DispatchQueue.main.async {
//                    self.Collectionview.reloadData()
//                }
//
//            }
//        })
//    }
//
//    @objc func showproductView() {
//        performSegue(withIdentifier: "showproductView", sender: nil)
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        fetchProduct ()
//        Collectionview.delegate = self
//        Collectionview.dataSource = self
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//
//
//}
//
//
//
////
////class ProductsInHome : NSObject {
////    var ProductName: String?
////    var ProductImageURL:String?
////    //  var DateOfAdd : Date?
////    var ProductBrand: String?
////   // var Size: String?
////    var RentalPrice: String?
////
////}

class HomeProductsCell: UICollectionViewCell {
    
  
    @IBOutlet weak var RentalPrice: UILabel!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var ProductImageURL: UIImageView!
    var post : Products!{
        didSet {
            self.updateUI()
        }
    }//
    func updateUI() {
        // Set shadow background view
        
        // change the caption
        self.RentalPrice.text = post.RentalPrice
        self.ProductName.text = post.ProductName
        
        //download Cell photo
        if let ProductImageURL = post.ProductImageURL{
            //1.create storage referance
            //let imageStorageRef = Storage.storage().reference(forURL:profileImageURL)
            let imageStorageRef = Storage.storage().reference().child("product_image")
            //2.observe method to download the Data
            imageStorageRef.getData(maxSize: 2*1024*1024, completion:{ [weak self](data,error)in
                if let error = error {
                    print("*******************:\(error)")
                }else{
                    //succes
                    if let imageData = data{
                        DispatchQueue.main.async {
                            //3.put the image to imageView
                            let pictuer = UIImage(data: imageData)
                            self?.ProductImageURL.image = pictuer}
                    }
                }
            })
            
        }
        
        
        
        
        
        
        
        
        
        /*
         // MARK: - Public API
         var users: User! {
         
         didSet {
         
         updateUI()
         
         }
         
         }
         
         // MARK: - Private
         
         //@IBOutlet weak var featuredImageView: UIImageView!
         //@IBOutlet weak var interestTitleLabel: UILabel!
         
         func updateUI() {
         
         if let profileImage = users.profileImageURL {
         
         self.usersImageView?.loadImageUsingCacheWithUrlString(urlString: profileImage)
         
         }
         
         usersNameLabel?.text! = users.name!
         
         }
         
         override func layoutSubviews() {
         super.layoutSubviews()
         
         self.layer.cornerRadius = 10.0
         self.clipsToBounds = true
         }
         
         */
        
    }
}




class Form_HowUseViewController: UIViewController {
    
    //How use Apatite button
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

