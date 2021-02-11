//
//  Images.swift
//  ConnectOng
//
//  Created by Alley Pereira on 11/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import Foundation
import CloudKit
// swiftlint:disable identifier_name
class Images {

	var id: CKRecord.ID
	var imageURL: CKAsset

	init?(record: CKRecord) {
		guard let imageURL = record["imageURL"] as? CKAsset else { return nil}

		id = record.recordID
		self.imageURL = imageURL

	}

	init(id: CKRecord.ID, imageURLAsset: CKAsset) {
		self.id = id
		self.imageURL = imageURLAsset
	}
}
