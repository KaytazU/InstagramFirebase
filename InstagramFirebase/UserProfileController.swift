//
//  UserProfileController.swift
//  InstagramFirebase
//
//  Created by Umuralp Kaytaz on 17/05/2018.
//  Copyright © 2018 Umuralp Kaytaz. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController {
    override func viewDidLoad() {
        
        collectionView?.backgroundColor = .white
        
        navigationItem.title = Auth.auth().currentUser?.uid
        
        fetchUser()
    }
    
    fileprivate func  fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (snapshot, str)  in
            
            print(snapshot.value ?? "")
            
            guard let dictionary = snapshot.value as? [String: Any] else{ return }
            
            let username = dictionary["username"] as? String
            self.navigationItem.title = username

        }) { (err) in
            print("Failed to fetch user: ", err)
        }
        
    }
}

