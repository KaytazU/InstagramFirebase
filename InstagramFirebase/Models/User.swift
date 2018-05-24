//
//  User.swift
//  InstagramFirebase
//
//  Created by Umuralp Kaytaz on 24/05/2018.
//  Copyright © 2018 Umuralp Kaytaz. All rights reserved.
//

import Foundation

struct User{
    
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
    
}
