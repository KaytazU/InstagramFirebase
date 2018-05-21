//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by Umuralp Kaytaz on 17/05/2018.
//  Copyright © 2018 Umuralp Kaytaz. All rights reserved.
//

import UIKit
import Firebase
class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Loading Main tab bar controller")
        
        if Auth.auth().currentUser == nil {
            //show if not logged in
            //This lets us wait until the main tab bar controller is inside of the UI
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true,completion: nil)
            }
            
            return
        }
        
        setupViewControllers()

    }
    
    func  setupViewControllers() {
        
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        let navController = UINavigationController(rootViewController: userProfileController)
        
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = .black
        
        viewControllers = [navController, UIViewController()]
        
    }

    
}

