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

	var takePictureHandler: () -> Void = { }

	let imagePickerButton: UIButton = {
		let imagePickerButton = UIButton()
		if #available(iOS 13.0, *) {
			imagePickerButton.setImage(UIImage(systemName: "camera"), for: .normal)
			imagePickerButton.setTitle(" Adicione uma foto ao caso", for: .normal)
		} else {
			imagePickerButton.setTitle("Adicione uma foto ao caso", for: .normal)
		}
		imagePickerButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
		imagePickerButton.tintColor = UIColor.init(named: "redCustomized")
		imagePickerButton.setTitleColor(UIColor.init(named: "redCustomized"), for: .normal)
		return imagePickerButton
	}()

	let descriptionLabel: UILabel = {
		let descriptionLabel = UILabel()
		descriptionLabel.text = "Opcional, porém as pessoas costumam ajudar mais quando tem uma foto"
		descriptionLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
		descriptionLabel.numberOfLines = 2
		return descriptionLabel
	}()

	@objc func createButtonWasTapped() {
		takePictureHandler()
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.selectionStyle = .none
		self.backgroundColor = .clear
		self.contentView.addSubview(imagePickerButton)
		self.contentView.addSubview(descriptionLabel)
		setupConstraints()

		imagePickerButton.addTarget(self, action: #selector(createButtonWasTapped), for: .touchUpInside)
	}

	func setupConstraints() {
		imagePickerButton.translatesAutoresizingMaskIntoConstraints = false
		descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			imagePickerButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40),
			imagePickerButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
			imagePickerButton.widthAnchor.constraint(equalToConstant: 280),
			imagePickerButton.heightAnchor.constraint(equalToConstant: 40),

			descriptionLabel.topAnchor.constraint(equalTo: self.imagePickerButton.bottomAnchor, constant: 5),
			descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
			descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30)
		])
	}


}
