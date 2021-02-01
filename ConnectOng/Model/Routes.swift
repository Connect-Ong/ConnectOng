//
//  Routes.swift
//  ConnectOng
//
//  Created by Alley Pereira on 21/08/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation


struct Routes {
    static let rootURL = "https://api-ajude-alguem.herokuapp.com"
    static let incidents = "/incidents"
    static let cadastrar = "/incidents"
}

class APIManager {
    
    static func getIncidents(completion: @escaping ([Incident]) -> Void) {
        let url = URL(string: Routes.rootURL+Routes.incidents)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let incidents: [Incident] = try JSONDecoder().decode([Incident].self, from: data)
                completion(incidents)
            } catch {
//                print(error)
            }
            
        }
        task.resume()
    }
}
