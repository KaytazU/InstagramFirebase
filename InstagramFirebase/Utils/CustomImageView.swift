//
//  CustomImageView.swift
//  InstagramFirebase
//
//  Created by Umuralp Kaytaz on 23/05/2018.
//  Copyright © 2018 Umuralp Kaytaz. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        print("Loading image...")
        
        lastURLUsedToLoadImage = urlString
        
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
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()
    }
    
    
}
