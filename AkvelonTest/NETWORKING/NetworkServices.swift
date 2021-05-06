//
//  NetworkServices.swift
//  AkvelonTest
//
//  Created by Danijel Vasov on 6.5.21..
//

import Foundation

struct NetworkServices {
    static let decoder = JSONDecoder()
    
    
    
    static func getApiUrlString() -> String {
        return "https://akvelon.free.beeceptor.com/users"
    }
    
    
    
    
//    static func getUsers(with urlString: String, completion: @escaping([User])->Void, failure: @escaping (Bool)->Void) {
//        guard let usersUrl = URL(string: urlString) else {return}
//
//        let task = URLSession.shared.dataTask(with: usersUrl) {(data, response, error) in
//
//            if error != nil {
//                failure(true)
//                return
//            }
//            guard let data = data else {return}
//
//            print("data :", String(data: data, encoding: .utf8)!)
//
//            if let responseUsersList = try? decoder.decode([User].self, from: data) {
//                completion(responseUsersList)
//            }
//        }
//        task.resume()
//    }
    
    
    //MARK: - got the error (429 - Too Many Requests Refer: https://beeceptor.com/pricing ) here, could not finish testing the method below.
    
    static func getUsers(with urlString: String, page:Int, completion: @escaping([User])->Void, failure: @escaping (Bool)->Void) {
        var usersUrl = URLComponents(string: urlString)
        var items = [URLQueryItem]()
        items.append(URLQueryItem(name: "page", value: String(page)))
        usersUrl?.queryItems = items
        guard let request = usersUrl?.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if error != nil {
                failure(true)
                return
            }
            guard let data = data else {return}
            
            print("data :", String(data: data, encoding: .utf8)!)
            
            if let responseUsersList = try? decoder.decode([User].self, from: data) {
                completion(responseUsersList)
            }
        }
        task.resume()
    }
    
    

}
