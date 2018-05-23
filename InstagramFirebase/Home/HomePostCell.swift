//
//  HomePostCell.swift
//  InstagramFirebase
//
//  Created by Umuralp Kaytaz on 23/05/2018.
//  Copyright © 2018 Umuralp Kaytaz. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    
    var post: Post? {
        didSet{
            guard let postImageUrl = post?.imageUrl else {return}
            
            photoImageView.loadImage(urlString: postImageUrl)
        }
    }
    
    let photoImageView: CustomImageView = {
       let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
