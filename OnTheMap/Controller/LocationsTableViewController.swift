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
    
    var studentLocations: [Result] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIClient.getStudentLocationData() { result, error in
            DispatchQueue.main.async {
                self.studentLocations =  result
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
    }
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
        
        tableView.deselectRow(at: indexPath, animated: true)
        let app = UIApplication.shared
        let url = URL(string: self.studentLocations[(indexPath as NSIndexPath).row].mediaURL)!
        
        if app.canOpenURL(url) {
            app.open(url)
            }
        }
    
    func handleSessionDeletion(succuss:Bool,error:Error?){
          if succuss {
              DispatchQueue.main.sync {
                  self.dismiss(animated: true, completion: nil)
              }
          }
      }
    
    @IBAction func LogoutButton(_ sender: Any) {
        APIClient.deleteSession(completion: handleSessionDeletion(succuss:error:))
    }
    
     @IBAction func addNewLocation(_ sender: Any) {
         
         let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNavigationController") as! UINavigationController
         
         present(navController, animated: true, completion: nil)
     }
    
    func setupUI() {
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addNewLocation(_:)))
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.LogoutButton(_:)))
        
        navigationItem.rightBarButtonItems = [plusButton]
        navigationItem.leftBarButtonItem = logoutButton
    }
    
    }


