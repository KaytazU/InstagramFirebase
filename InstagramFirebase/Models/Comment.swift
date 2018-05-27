//
//  Comment.swift
//  InstagramFirebase
//
//  Created by Umuralp Kaytaz on 27/05/2018.
//  Copyright © 2018 Umuralp Kaytaz. All rights reserved.
//

import Foundation

struct Comment {
    let text: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""

    }
}



