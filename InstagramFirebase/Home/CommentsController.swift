//
//  CommentsController.swift
//  InstagramFirebase
//
//  Created by Umuralp Kaytaz on 26/05/2018.
//  Copyright © 2018 Umuralp Kaytaz. All rights reserved.
//

import UIKit

class CommentsController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Comments"
        
        collectionView?.backgroundColor = .red
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    var containerView: UIView = {
        
        let aContainerView = UIView()
        aContainerView.backgroundColor = .white
        aContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        aContainerView.addSubview(submitButton)
        submitButton.anchor(top: aContainerView.topAnchor, left: nil, bottom: aContainerView.bottomAnchor, right: aContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 0)
        
        let aTextField = UITextField()
        aTextField.placeholder = "Enter Comment"
        aContainerView.addSubview(aTextField)
        aTextField.anchor(top: aContainerView.topAnchor, left: aContainerView.leftAnchor, bottom: aContainerView.bottomAnchor, right: submitButton.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        return aContainerView
    }()
    
    @objc func handleSubmit(){
        print("Handling submit...")
    }
    
    override var inputAccessoryView: UIView? {
        get{
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
}




