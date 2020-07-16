//
//  PostLocationViewController.swift
//  OnTheMap
//
//  Created by Khalid Aqeeli on 16/07/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import UIKit

class PostLocationViewController: UIViewController {

    var location = Result(firstName: "ash", lastName: "k", longitude: 30.264265, latitude: -97.747505, mapString: "Austin, TX", mediaURL: "https://www.udacity.com", uniqueKey: "92840192", objectID:"bs89d3cloqigfo8fpshg"  , createdAt: "2020-07-16T18:03:57.002Z", updatedAt: "2020-06-04T00:47:32.440Z")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    
    }
    
    
    @IBAction func postLocationButton(_ sender: Any) {
        
        APIClient.PostLocation(reslut: location) { result, error in
        DispatchQueue.main.async {
                print("Done, GO!!.")
            }
        }
    }
    

}
