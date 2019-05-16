//
//  UIImageView+Extension.swift
//  MVVM-Movie-App
//
//  Created by Sagar More on 14/05/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    /// Method get download image from server with url, with help of caching mechanism
    /// This caches the image in NSCache as OS automatically removes data from NSCache when low memory warning encounter
    /// - Parameter urlString: image url in string format
    func getImageWith(_ urlString : String){
        guard let url = URL(string: urlString) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    guard let imageToCache = UIImage(data: response) else { return }
                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }
            }
        }.resume()
    }
}
