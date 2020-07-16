//
//  LocationsTableViewController.swift
//  OnTheMap
//
//  Created by Khalid Aqeeli on 15/07/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import UIKit

class LocationsTableViewController: UIViewController {

    let CellId = "LocationCell"
    var studentLocations = [Result]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        APIClient.getStudentLocationData() { result, error in
            DispatchQueue.main.async {
                self.studentLocations =  result
                self.tableView.reloadData()
            }
        }
        
    }

    
    // MARK:- Inform the user if the download fails
    
    
    // MARK:- When the pins in the map are tapped, display the relevant information
    
    
    // MARK:- When pin annotation is tapped, the link opened in Safar
    
    

}


extension LocationsTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId")!
        let StudentLoc = studentLocations[indexPath.row]
        cell.textLabel?.text = "\(StudentLoc.firstName) \(StudentLoc.lastName)"
        cell.detailTextLabel?.text = StudentLoc.mediaURL
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
