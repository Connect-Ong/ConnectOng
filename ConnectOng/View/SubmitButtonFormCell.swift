//
//  SubmitButtonFormCell.swift
//  ConnectOng
//
//  Created by Alley Pereira on 09/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import UIKit

class SubmitButtonFormCell: UITableViewCell {

	static let cellIdentifier: String = "SubmitButtonFormCell"

	var submitHandler: () -> Void = { }

	let submitButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Criar", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
		button.setTitleColor(UIColor.white, for: .normal)
		button.layer.cornerRadius = 10
		button.backgroundColor = UIColor.init(named: "redCustomized")
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	@objc func createButtonWasTapped() {
		submitHandler()
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.selectionStyle = .none
		self.contentView.addSubview(submitButton)
		self.backgroundColor = .clear
		setupConstraints()

		submitButton.addTarget(self, action: #selector(createButtonWasTapped), for: .touchUpInside)
	}

	func setupConstraints() {
		submitButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			submitButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
			submitButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),

			submitButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
			submitButton.heightAnchor.constraint(equalToConstant: 40)

		])
	}

}
