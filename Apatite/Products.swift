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
   var DateOfAdd : String?
    var Email: String?
    var RentalDuration: String?
    
}

class ProductsCell: UITableViewCell{
    
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var ProductImage: UIImageView!
    
    @IBOutlet weak var DateOfAdd: UILabel!
    
    @IBOutlet weak var RentalDuration: UILabel!
    
    @IBOutlet weak var OwnerEmail: UILabel!
    
}

class MyProductsCell: UITableViewCell{
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    
    @IBOutlet weak var RentalDuration: UILabel!
    
    @IBOutlet weak var DateOfAdd: UILabel!
    
}

