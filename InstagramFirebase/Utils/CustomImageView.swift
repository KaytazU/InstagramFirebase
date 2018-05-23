//
//  CustomImageView.swift
//  InstagramFirebase
//
//  Created by Umuralp Kaytaz on 23/05/2018.
//  Copyright © 2018 Umuralp Kaytaz. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        
        lastURLUsedToLoadImage = urlString
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else{ return }
        //dont forget resume at the end of dataTask
        URLSession.shared.dataTask(with: url) { (data, reponse , err) in
            if let err = err {
                print("Failed to fetch post image:", err)
                return
            }
            //images wont have repeating effect
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else {return}
            
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()
    }
    
    
}
