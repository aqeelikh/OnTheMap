//
//  AddLocationInfoViewController.swift
//  OnTheMap
//
//  Created by Khalid Aqeeli on 16/07/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import UIKit
import CoreLocation

class AddLocationInfoViewController: UIViewController {

    @IBOutlet weak var LocationTextField: UITextField!
    @IBOutlet weak var mediaURLTextField: UITextField!
    
    var location:Result?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func passStudentInformation(location:Result){
        
        getCoordinate(addressString: location.mapString) { (locationcor, error) in

            self.location?.latitude = locationcor.latitude
            self.location?.longitude = locationcor.longitude
            self.performSegue(withIdentifier: "submitLocation", sender: self.location)
        }
    }
    
    
    func getCoordinate( addressString : String,
            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                        
                    completionHandler(location.coordinate, nil)
                    return
                }
            }else {
                self.showAlert(message: "Error, enter a valid address")
            }
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let destinationVC = segue.destination as! PostLocationViewController
        destinationVC.location =  self.location
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
          if segue.identifier == "submitLocation", let vc = segue.destination as? PostLocationViewController {
              vc.location = (sender as! Result)
          }
      }

    @IBAction func findOnMapButton(_ sender: Any) {
        
        guard let LocationTF = self.LocationTextField.text, LocationTF != "" else  {
                showAlert(message: "Enter location information")
        return
        }
    
        guard let mediaURLTF = self.mediaURLTextField.text, mediaURLTF != "" else {
                showAlert(message: "Enter URL ")
            return
        }
        
        self.location = Result(firstName: "Jhone", lastName: "Doe", longitude: 0, latitude: 0, mapString: LocationTF , mediaURL: mediaURLTF, uniqueKey: "92840192", objectID:"bs89d3cloqigfo8fpshg"  , createdAt: "2020-07-16T18:03:57.002Z", updatedAt: "2020-06-04T00:47:32.440Z")
        
        passStudentInformation(location: location!)
    }
    
    func showAlert(message:String){
            let alertController = UIAlertController(title: "On The Map", message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
    }
        
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelButton(_:)))

        navigationItem.leftBarButtonItem = cancelButton
    }
}
