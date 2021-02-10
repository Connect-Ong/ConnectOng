//
//  Extensions.swift
//  ConnectOng
//
//  Created by Alley Pereira on 10/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
	static func random() -> UIColor {
		return UIColor.init(red: CGFloat.random(in: 0...1),
							green: CGFloat.random(in: 0...1),
							blue: CGFloat.random(in: 0...1),
							alpha: 1)
	}
}

extension UIDevice {

	func sizeForCollectionCell() -> CGSize {

		let sizeForSE = CGSize(
			width: (UIScreen.main.bounds.width / 2.18),
			height: (UIScreen.main.bounds.height / 2.5)
		)

		let sizeForMini = CGSize(
			width: (UIScreen.main.bounds.width / 2.18),
			height: (UIScreen.main.bounds.height / 3)
		)

		let sizeFor11 = CGSize(
			width: (UIScreen.main.bounds.width / 2.16),
			height: (UIScreen.main.bounds.height / 3)
		)

		if self.name.contains("iPhone 6") ||
		   self.name.contains("iPhone 7") ||
		   self.name.contains("iPhone 8") ||
		   self.name.contains("iPhone SE") {
			return sizeForSE
		}

		if self.name.contains("mini") {
			return sizeForMini
		}

		return sizeFor11

	}

}
