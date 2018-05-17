//
//  UserProfileHeader.swift
//  InstagramFirebase
//
//  Created by Umuralp Kaytaz on 17/05/2018.
//  Copyright © 2018 Umuralp Kaytaz. All rights reserved.
//

import UIKit
import Firebase
class UserProfileHeader: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        addSubview(profileImageView)
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
    }
    
    var user: User?{
        didSet{
           setupProfileImage()
        }
    }
    
    fileprivate func setupProfileImage(){
        guard let profileImageUrl = user?.profileImageUrl else {return}
        
        guard let url = URL(string: profileImageUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check for the error, then construct the image using data
            if let err = err {
                print("Failed to fetch profile image: " , err)
                return
            }
            //to be more carefull abour URL session , you can check the response status of 200 (HTTP OK)
            
            guard let data = data else {return}
            
            let image = UIImage(data: data)
            
            //need to get back onto the main UI thread
            DispatchQueue.main.async {
                self.profileImageView.image = image
                }
            }.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
