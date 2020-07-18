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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let spinner = self.startAnActivityIndicator()
        spinner.stopAnimating()
        
    }
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
        APIClient.PostLocation(reslut: location, completion: self.handlerPostLocationResonse(success:error:))
    }
    
    func handlerPostLocationResonse(success:Bool,error:Error?) -> Void{
        
        if success {
            DispatchQueue.main.sync {
                self.dismiss(animated: true, completion: nil)
            }
        }else{
             DispatchQueue.main.sync {
            self.showAlert(message: error!.localizedDescription)
            }
        }
    }
}
