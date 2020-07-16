//
//  AddLocationInfoViewController.swift
//  OnTheMap
//
//  Created by Khalid Aqeeli on 16/07/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import UIKit

class AddLocationInfoViewController: UIViewController {

    @IBOutlet weak var LocationTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func findOnMapButton(_ sender: Any) {
        self.performSegue(withIdentifier: "submitLocation", sender: nil)
    }
    
   
}
