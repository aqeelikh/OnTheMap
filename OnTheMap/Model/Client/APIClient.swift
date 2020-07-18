//
//  APIClient.swift
//  OnTheMap
//
//  Created by Khalid Aqeeli on 15/07/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import Foundation


class APIClient {
    
    static let user = User()
    
    enum APIInformation {
        static var sessionId:String = ""
    }
    
    
    enum Endpoint {
        static let base:String = "https://onthemap-api.udacity.com/v1/"
        static let downloadLimit:String = "StudentLocation?order=-updatedAt&limit=100"
        static let loginPath:String = "session"
        static let studentLocation:String = "StudentLocation"
        
        case login
        case getStudentLocation
        case postStudentLocation
        
        var stringValue: String {
            switch self {
            case .login:
                return Endpoint.base + Endpoint.loginPath
            case .getStudentLocation:
                return Endpoint.base + Endpoint.downloadLimit
            case .postStudentLocation:
                return Endpoint.base + Endpoint.studentLocation
            }
        }
        var url:URL {
            return URL(string: stringValue)!
        }
    }
    
    class func login(username:String,password:String,completion: @escaping (_ succuss:Bool, String) -> Void) {
       
        
       var request = URLRequest(url: Endpoint.login.url)
               request.httpMethod = "POST"
               request.addValue("application/json", forHTTPHeaderField: "Accept")
               request.addValue("application/json", forHTTPHeaderField: "Content-Type")
               // encoding a JSON body from a string, can also use a Codable struct
               request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
               var errString: String?
               let session = URLSession.shared
               let task = session.dataTask(with: request) { data, response, error in
                   if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                       if statusCode < 400 {
                           guard let data = data else{
                                errString = "cant get data"
                               return
                           }
                           do {
                               completion(true, "")
                               let decoder = JSONDecoder()
                               //Whats happening here ?! :|
                               let range = 5..<data.count
                               let newData = data.subdata(in: range)
                               let resObject = try decoder.decode(LoginResponse.self, from: newData)
                               APIInformation.sessionId = resObject.session.id
                           }catch{
                               print(error)
                               errString = "can't parse response"
                           }
                       }else{
                        errString = "Did not specify exactly one credential"
                        }
                   }else{
                    errString = "Check Network Connection"
            }
                guard let err = errString else { return }
                DispatchQueue.main.async {
                        completion(false,err)
                }
        }
               task.resume()
    }
    
    class func deleteSession(completion: @escaping (Bool, Error?) -> Void) {
        
        var request = URLRequest(url: Endpoint.login.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error…
              return
          }
          let range = 5..<data!.count
          let newData = data?.subdata(in: range) /* subset response data! */
          completion(true, error)
        }
        task.resume()
    }
    
    class func PostLocation(reslut:Result,completion: @escaping ([Result], Error?) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(reslut.uniqueKey)\", \"firstName\": \"\(reslut.firstName)\", \"lastName\": \"\(reslut.lastName)\",\"mapString\": \"\(reslut.mapString)\", \"mediaURL\": \"\(reslut.mediaURL)\",\"latitude\": \(reslut.latitude), \"longitude\": \(reslut.longitude)}".data(using: .utf8)

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error…
              return
          }
          completion([], nil)
        }
        task.resume()
    }
    
    
    class func getStudentLocationData(completion: @escaping ([Result], Error?) -> Void) {
        
        let request = URLRequest(url: Endpoint.getStudentLocation.url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error...
              return
          }
          let decoder = JSONDecoder()
          do {
            let responseObject = try decoder.decode(StudentLocation.self, from: data!)
            completion(responseObject.results, nil)
          } catch {
              completion([], error)
          }

        }
        task.resume()
    }
    
}
