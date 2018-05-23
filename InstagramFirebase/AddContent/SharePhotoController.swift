//
//  SharePhotoController.swift
//  InstagramFirebase
//
//  Created by Umuralp Kaytaz on 22/05/2018.
//  Copyright © 2018 Umuralp Kaytaz. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    //optional so we can set to nil initially
    var selectedImage: UIImage? {
        didSet{
//            print(selectedImage)
            self.imageView.image = selectedImage
        }
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupImageAndTextViews()
    }
    
    let imageView: UIImageView = {
        let iv  = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    //using text view is cleaner than using text field
    let textView: UITextView = {
       let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    fileprivate func setupImageAndTextViews(){
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        //to get the bottom of nav bar use topLayoutGuide
        containerView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
        
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    
    @objc func handleShare(){
        guard let caption = textView.text, caption.characters.count > 0 else {return}
//        print("Sharing photo")
        guard let image = selectedImage else {return}
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else {return}
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let filename = NSUUID().uuidString
        Storage.storage().reference().child("posts").child(filename).putData(uploadData, metadata: nil) { (metadata, err) in
            
            if let err = err{
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to upload image")
                return
            }
            
            guard let imageURL = metadata?.downloadURL()?.absoluteString else {return}
            
            print("Successfully uploaded post image:", imageURL)
            
            self.saveToDatabaseWithImageUrl(imageUrl: imageURL)
        }
    }
    
    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String){
        guard let postImage = selectedImage else {return}
        guard let caption = textView.text else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("posts").child(uid)
        //for a structured list storage in a firebase child database
        let ref = userPostRef.childByAutoId()
        
        let values = ["imageUrl": imageUrl, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err{
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to save post to DB")
                return
            }
            print("Successfully saved post to DB")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
