//
//  CKContainer.swift
//  ConnectOng
//
//  Created by Alley Pereira on 11/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import UIKit
import CloudKit

class CloudKitModel {

	let containerIdentifier: CKContainer
	let publicDB: CKDatabase

	static let current = CloudKitModel()

	init() {

		containerIdentifier = CKContainer.init(identifier: "iCloud.com.AlleyPereira.ConnectOng")
		publicDB = containerIdentifier.publicCloudDatabase
	}

	// MARK: - Fetch Request
	func fetchImage(_ completion: @escaping (Result<[Images], Error>) -> Void) {

		let predicate = NSPredicate(value: true)

		let query = CKQuery(recordType: "imageURL", predicate: predicate)

		publicDB.perform(query, inZoneWith: CKRecordZone.default().zoneID) { result, error in

			if let error = error {
				DispatchQueue.main.async {
					completion(.failure(error))
				}
			}

			guard let arrayCKRecord = result else { return }

			let images = arrayCKRecord.compactMap {
				Images.init(record: $0)
			}

			DispatchQueue.main.async {
				completion(.success(images))
			}
		}
	}

	func saveImage(image: Images, completion: @escaping (Result<CKRecord,Error>) -> Void) {

		let newRecord = CKRecord(recordType: "image")
		newRecord.setValue(image.imageURL, forKey: "image")

		publicDB.save(newRecord) { result, error in

			if let error = error {
				DispatchQueue.main.async {
					completion(.failure(error))
				}
			}

			if let registro = result {
				DispatchQueue.main.async {
					completion(.success(registro))
				}
			}
		}
	}
}
