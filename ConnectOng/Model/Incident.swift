//
//  Incident.swift
//  ConnectOng
//
//  Created by Alley Pereira on 21/08/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation

// Um incident do meu array de incidents da controller
//swiftlint:disable identifier_name
struct Incident: Encodable, Decodable {
    let id: Int
    let title: String
    let description: String
    let value: String
    let ongId: String
    let name: String
    let email: String
    let whatsapp: String
    let city: String
    let uf: String
    let imgURL: String
    let sensibleContent: Bool
    
    enum CodingKeys: String, CodingKey {
        case ongId = "ong_id"
        case imgURL = "img_url"
        case sensibleContent = "sensible_content"
        case id, title, description, value, name, email, whatsapp, city, uf
    }
}
