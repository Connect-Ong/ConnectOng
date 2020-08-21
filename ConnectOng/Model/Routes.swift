//
//  Routes.swift
//  ConnectOng
//
//  Created by Alley Pereira on 21/08/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation


struct Routes {
    static let rootURL = "http://localhost:3333"
    static let incidents = "/incidents/"
}

class APIManager {
    
    static func getIncidents(completion: @escaping ([Incident]) -> Void) {
        let url = URL(string: Routes.rootURL+Routes.incidents)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            print(data)
            
            do {
                let incidents: [Incident] = try JSONDecoder().decode([Incident].self, from: data)
                completion(incidents)
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
}
