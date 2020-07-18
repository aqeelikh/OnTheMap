//
//  PostLocationViewController.swift
//  OnTheMap
//
//  Created by Khalid Aqeeli on 16/07/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import UIKit
import MapKit

class PostLocationViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var toolBar: UIToolbar!

    var location: Result!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
    }
    
    func setupMap() {
        
        let lat = CLLocationDegrees(self.location.latitude)
        let long = CLLocationDegrees(self.location.longitude)
            
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

        // The lat and long are used to create a CLLocationCoordinates2D instance.
        let first = location.firstName
        let last = location.lastName
        let mediaURL = location.mediaURL
            
        // Here we create the annotation and set its coordiate, title, and subtitle properties
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.title = "\(first) \(last)"
        annotation.subtitle = mediaURL
        
        self.mapView.addAnnotation(annotation)
        // Setting current mapView's region to be centered at the pin's coordinate
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
               mapView.setRegion(region, animated: true)
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
         
         let reuseId = "pin"
         
         var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

         if pinView == nil {
             pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
             pinView!.canShowCallout = true
             pinView!.pinTintColor = .red
             pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
         }
         else {
             pinView!.annotation = annotation
         }
         
         return pinView
     }
        
    @IBAction func postLocationButton(_ sender: Any) {
        
        APIClient.PostLocation(reslut: location) { result, error in
        DispatchQueue.main.async {
             self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
//    func handlerPostLocationResonse(success:Bool,error:Error?,statuscode:Int) -> Void{
//
//        switch statuscode {
//        case 200:
//            DispatchQueue.main.sync {
//                self.performSegue(withIdentifier: "showMap", sender: nil)
//            }
//        case 400 :
//            showAlert(message: "Wrong credentials. try again")
//        case 401 :
//            showAlert(message: "Unauthenticated Access")
//        case 404:
//            showAlert(message: "Not Found")
//        case 500:
//            showAlert(message: "Internal Server Error")
//        default:
//            showAlert(message: "Cannot post information, try again later")
//        }
//    }
//
//    //MARK:- Notify the user if the login fails
//    func showAlert(message:String){
//        DispatchQueue.main.sync {
//        let alertController = UIAlertController(title: "On The Map", message: message, preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
//        self.present(alertController, animated: true, completion: nil)
//            }
//        }

}
