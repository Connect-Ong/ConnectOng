//
//  TextFieldFormCell.swift
//  ConnectOng
//
//  Created by Alley Pereira on 08/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import UIKit

class TextFieldFormCell: UITableViewCell {

	static let cellIdentifier: String = "TextFieldFormCell"

	let textLabelForm: UILabel = {
		let textLabel = UILabel()
		textLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		return textLabel
	}()

	let textFieldForm: UITextField = {
		let textField = UITextField()
		textField.backgroundColor = .white
		textField.placeholder = "Oi sou um placeholder"
		textField.tintColor = UIColor(named: "redCustomized")
		textField.clearButtonMode = .always // x que aparece de lado pra limpar o campo

		// Colocar espaçamento no inset do textfield
		let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.size.height))
		leftView.backgroundColor = textField.backgroundColor
		textField.leftView = leftView
		textField.leftViewMode = UITextField.ViewMode.always

		return textField
	}()

	func setupTextValue(title: String, placeholder: String, keyboardType: UIKeyboardType) {
		textLabelForm.text = title
		textFieldForm.placeholder = placeholder
		textFieldForm.keyboardType = keyboardType
		
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.selectionStyle = .none

		self.backgroundColor = .clear
		self.contentView.backgroundColor = .clear

		self.contentView.addSubview(textLabelForm)
		self.contentView.addSubview(textFieldForm)
		setupConstraints()
	}

	func setupConstraints() {
		textLabelForm.translatesAutoresizingMaskIntoConstraints = false
		textFieldForm.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			textLabelForm.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
			textLabelForm.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
			textLabelForm.heightAnchor.constraint(equalToConstant: 22),

			textFieldForm.topAnchor.constraint(equalTo: self.textLabelForm.bottomAnchor, constant: 10),
			textFieldForm.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
			textFieldForm.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
			textFieldForm.heightAnchor.constraint(equalToConstant: 40)
		])
	}

}
