//
//  TableViewCell.swift
//  Apatite
//
//  Created by Amal Alqadhibi on 25/03/2018.
//  Copyright © 2018 Amal Alqadhibi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var LogoImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
