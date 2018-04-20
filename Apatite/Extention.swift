//
//  Extention.swift
//  Apatite
//
//  Created by Najla Awadh on 03/08/1439 AH.
//  Copyright © 1439 Amal Alqadhibi. All rights reserved.
//

import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageUsingCacheWithUrlString(urlString: String){
        
        if let cachedImage = imageCache.object (forKey: urlString as AnyObject )as?
            UIImage{
            self.image = cachedImage
            return
        }
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url! as URL, completionHandler:{(data,response,error)in
            if error != nil {
                print (error)
                return  }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage,forKey: urlString as AnyObject )
                    self.image = downloadedImage }
            }
        }).resume()
    }
    
}

