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
        static var userInfo = User()
    }
    
    
    enum Endpoint {
        static let base:String = "https://onthemap-api.udacity.com/v1/"
        static let downloadLimit:String = "StudentLocation?order=-updatedAt"
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
    
    class func login(username:String,password:String,completion: @escaping (Bool, Error?) -> Void) {
        
        var request = URLRequest(url: Endpoint.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                print(statusCode)
                if statusCode < 400 {
                    guard let data = data else{
                        completion(false,nil)
                        print("there is no data")
                        return
                    }
                    do {
                        completion(true, nil)
                        print("we are in")
                        let decoder = JSONDecoder()
                        //Whats happening here ?! :|
                        let range = 5..<data.count
                        let newData = data.subdata(in: range)
                        print(String(data: newData, encoding: .utf8)!)
                        let resObject = try decoder.decode(LoginResponse.self, from: newData)
                        APIInformation.sessionId = resObject.session.id
                    }catch{
                        print(error)
                        completion(false,nil)
                        print("there is an error")
                    }
//                      let range = 5..<data.count
//                      let newData = data.subdata(in: range) /* subset response data! */
//                      print(String(data: newData, encoding: .utf8)!)
                }
            }

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
          print(String(data: data!, encoding: .utf8)!)
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
          //print(String(data: data!, encoding: .utf8)!)
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











//
//
//
//    class func creatSessionId(acc:Account,sec:Session,completion: @escaping (Bool, Error?) ->Void) {
//
//        var request = URLRequest(url: Endpoint.login.url)
//         request.httpMethod = "POST"
//         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//         let body = LoginResponse(account: acc, session: sec)
//         request.httpBody = try! JSONEncoder().encode(body)
//
//         let task = URLSession.shared.dataTask(with: request){(data, res, error) in
//             guard let data = data else{
//                 completion(false,nil)
//                 return
//             }
//             do {
//                 let decoder = JSONDecoder()
//                 let resObject = try decoder.decode(LoginResponse.self, from: data)
////                 Auth.sessionId = resObject.sessionID
//                 completion(true, nil)
//             }catch{
//                 print(error)
//                 completion(false,nil)
//             }
//         }
//         task.resume()
//    }
//
//
//     class func login(username:String,password:String,completion: @escaping (Bool, Error?) ->Void) {
//        var request = URLRequest(url: Endpoint.login.url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////        // encoding a JSON body from a string, can also use a Codable struct
////        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)}\"}".data(using: .utf8)
////        let session = URLSession.shared
////        let task = session.dataTask(with: request) { data, response, error in
////          var errString: String?
////          if let statusCode = (response as? HTTPURLResponse)?.statusCode { //Request sent succesfully
////              if statusCode < 400 { //Response is ok
////
////                  let newData = data?.subdata(in: 5..<data!.count)
////                  if let json = try? JSONSerialization.jsonObject(with: newData!, options: []),
////                      let dict = json as? [String:Any],
////                      let sessionDict = dict["session"] as? [String: Any],
////                      let accountDict = dict["account"] as? [String: Any]  {
////
////                      self.sessionId = sessionDict["id"] as? String
////                      self.userInfo.key = account["key"] as? String
////
////                      getPublicUserName(completion: { (err) in
////
////                      })
////                  } else { //Err in parsing data
////                      errString = "Couldn't parse response"
////                  }
////              } else { //Err in given login credintials
////                  errString = "Provided login credintials didn't match our records"
////              }
////          } else { //Request failed to sent
////              errString = "Check your internet connection"
////          }
////          let range = (5..<data!.count)
////          let newData = data?.subdata(in: range) /* subset response data! */
////          print(String(data: newData!, encoding: .utf8)!)
////        }
////        task.resume()
//    }
