//
//  IncidentJSONManager.swift
//  ConnectOng
//
//  Created by Alley Pereira on 26/08/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation

class IncidentJSONManager {
    
    static func createIncidentList(arrayIncident: [Incident]) {
        let file = File.init(ext: "json", name: "incidents", folderName: nil)
        if let data = try? JSONEncoder().encode(arrayIncident) {
             file.create(content: data)
        }
    }
    
    static func readIncidentList() -> [Incident] {
        let file = File.init(ext: "json", name: "incidents", folderName: nil)
        if let data = file.read() {
            let persistedIncidents = (try? JSONDecoder().decode([Incident].self, from: data)) ?? []
            return persistedIncidents
        }
        return []
    }
}
