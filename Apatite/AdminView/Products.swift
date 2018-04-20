//
//  Products.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 04/04/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import Foundation
import UIKit
class Products : NSObject {
    var ProductName: String?
    var ProductImageURL:String?
    var RentalPrice : String?
    var ProductDescription : String?
    var ReturnMess : String?
    var Email: String?
    var RentalDuration: String?
    var ProductID: String?
}

class ProductsCell: UITableViewCell{
    
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var ProductImage: UIImageView!
    
    @IBOutlet weak var ReturnMess: UILabel!
    
    @IBOutlet weak var RentalDuration: UILabel!
    
    @IBOutlet weak var OwnerEmail: UILabel!
    
}

class MyProductsCell: UITableViewCell{
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    
    @IBOutlet weak var RentalDuration: UILabel!
    
    @IBOutlet weak var ReturnMess: UILabel!
    
}
class Request :UITableViewCell{
    @IBOutlet weak var OwnerEmail: UILabel!
    @IBOutlet weak var RentalDuration: UILabel!
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    
}

