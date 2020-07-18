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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    @IBAction func signUpButton(_ sender: Any) {
        
        let app = UIApplication.shared
        let url = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated")!
        if app.canOpenURL(url) {
            app.open(url)
            }
        }

    //MARK:- Allow the user to login
    @IBAction func loginButton(_ sender: Any) {
        APIClient.login(username: self.emailTextField.text ?? "No" , password: self.passwordTextField.text ?? "no", completion: self.handlerLoginResonse(success:error:statuscode:))
    }
            
    
    func handlerLoginResonse(success:Bool,error:Error?,statuscode:Int) -> Void{
        
        switch statuscode {
        case 200:
            DispatchQueue.main.sync {
                self.performSegue(withIdentifier: "showMap", sender: nil)
            }
        case 400 :
            showAlert(message: "Wrong credentials. try again")
        case 401 :
            showAlert(message: "Unauthenticated Access")
        case 404:
            showAlert(message: "Not Found")
        case 500:
            showAlert(message: "Internal Server Error")
        default:
            showAlert(message: "Error, email or password is invalid ")
        }
    }
    
    //MARK:- Notify the user if the login fails
    func showAlert(message:String){
        DispatchQueue.main.sync {
        let alertController = UIAlertController(title: "On The Map", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
            }
        }
}

