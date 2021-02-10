//
//  Networking.swift
//  ConnectOng
//
//  Created by Alley Pereira on 10/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import UIKit

//swiftlint:disable vertical_parameter_alignment
class Networking {

	static func createIncidentRequest(ongID: String?,
									  title: String?,
									  description: String?,
									  value: String?,
									  imgUrl: String?,
//									  city: String,
									  completion: @escaping () -> Void = { }) {

		guard let url = URL(string: Routes.rootURL+Routes.cadastrar) else { return }
		let urlRequest = URLRequest(url: url)
		var request = urlRequest

		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.setValue(ongID, forHTTPHeaderField: "Authorization")

		let jsonDict: [String: Any] = [
			"title": title ?? "",
			"description": description ?? "",
			"value": Double(value!) ?? 0,
			"img_url": imgUrl ?? "",
//			"city": city,
			"sensible_content": false
		]

		let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: [])
		request.httpBody = jsonData

		URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
			if let  error = error {
				print("Erro na requisicao"+error.localizedDescription)
			}
			guard let response = response as? HTTPURLResponse else {
				print("Response nao veio HTTP")
				return
			}
			print("Status Code: \(response.statusCode)")
			print(String(data: data!, encoding: .utf8)!)

			DispatchQueue.main.async {
				completion()
			}

		}).resume()
	}


	static func getIncidents(completion: @escaping ([Incident]) -> Void) {
		let url = URL(string: Routes.rootURL+Routes.incidents)!
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = "GET"

		let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, _) in
			guard let data = data else { return }

			do {
				let incidents: [Incident] = try JSONDecoder().decode([Incident].self, from: data)
				completion(incidents)
			} catch {
				print("Erro no getIncidents",error.localizedDescription)
			}

		}
		task.resume()
	}
}
