//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Khalid Aqeeli on 14/07/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    //MARK:- Notify the user if the login fails

    
    //MARK:- Allow the user to login
    
    @IBAction func loginButton(_ sender: Any) {
        
        if true {
             self.performSegue(withIdentifier: "showMap", sender: nil)
        }
       
    }
    
    
    
}

