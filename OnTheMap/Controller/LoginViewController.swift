//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Khalid Aqeeli on 14/07/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK:- IBOutlet
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func signUpButton(_ sender: Any) {
        
        let app = UIApplication.shared
        let url = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated")!
        if app.canOpenURL(url) {
            app.open(url)
            }
        }

    //MARK:- Allow the user to login
    @IBAction func loginButton(_ sender: Any) {
        APIClient.login(username: self.emailTextField.text ?? "No" , password: self.passwordTextField.text ?? "no", completion: self.handlerLoginResonse(success:error:))
    }
            
    
    func handlerLoginResonse(success:Bool,error:Error?) -> Void{
        
        if success {
            DispatchQueue.main.sync {
                self.performSegue(withIdentifier: "showMap", sender: nil)
                return
            }
        }else{
            DispatchQueue.main.sync {
            self.showAlert(message: error!.localizedDescription)
            }
        }
    }
}

