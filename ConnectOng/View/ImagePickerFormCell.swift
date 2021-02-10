//
//  ImagePickerView.swift
//  ConnectOng
//
//  Created by Alley Pereira on 09/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import UIKit

class ImagePickerFormCell: UITableViewCell {

	static let cellIdentifier: String = "ImagePickerButton"

	let imagePickerButton: UIButton = {
		let imagePickerButton = UIButton()
		imagePickerButton.setTitle("📷 Adicione uma foto ao caso", for: .normal)
		imagePickerButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
		imagePickerButton.setTitleColor(UIColor.init(named: "redCustomized"), for: .normal)
		return imagePickerButton
	}()

	@objc func createButtonWasTapped() {
		print("Tapped here 🖖🏼")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.backgroundColor = .clear
		self.contentView.addSubview(imagePickerButton)
		setupConstraints()

		imagePickerButton.addTarget(self, action: #selector(createButtonWasTapped), for: .touchUpInside)
	}

	func setupConstraints() {
		imagePickerButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			imagePickerButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
			imagePickerButton.widthAnchor.constraint(equalToConstant: 280),
			imagePickerButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
			imagePickerButton.heightAnchor.constraint(equalToConstant: 40)
		])
	}


}
