//
//  ImagePickerDelegate.swift
//  ConnectOng
//
//  Created by Alley Pereira on 09/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import UIKit

public protocol ImagePickerDelegate: class {
	func didSelect(image: UIImage?)
}
