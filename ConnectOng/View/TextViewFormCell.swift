//
//  TextViewFormCell.swift
//  ConnectOng
//
//  Created by Alley Pereira on 08/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import UIKit

class TextViewFormCell: UITableViewCell {

	private var placeholder: String = ""

	static let cellIdentifier: String = "TextViewFormCell"

	let textLabelForm: UILabel = {
		let textLabel = UILabel()
		textLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		return textLabel
	}()

	let textViewForm: UITextView = {
		let textView = UITextView()
		textView.backgroundColor = .white
		textView.tintColor = UIColor(named: "redCustomized")
		return textView
	}()

	override func layoutSubviews() {
		super.layoutSubviews()

		textViewForm.delegate = self

		selectionStyle = .none
		backgroundColor = .clear
		contentView.backgroundColor = .clear

		self.contentView.addSubview(textLabelForm)
		self.contentView.addSubview(textViewForm)
		setupConstraints()
	}

	func setupTextValue(title: String, placeholder: String) {
		textLabelForm.text = title
		self.placeholder = placeholder

		self.textViewDidEndEditing(textViewForm)
	}

	func setupConstraints() {
		textLabelForm.translatesAutoresizingMaskIntoConstraints = false
		textViewForm.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			textLabelForm.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
			textLabelForm.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
			textLabelForm.heightAnchor.constraint(equalToConstant: 22),

			textViewForm.topAnchor.constraint(equalTo: self.textLabelForm.bottomAnchor, constant: 10),
			textViewForm.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
			textViewForm.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
			textViewForm.heightAnchor.constraint(equalToConstant: 80)
		])
	}


}

extension TextViewFormCell: UITextViewDelegate {

	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.textColor == UIColor.lightGray {
			textView.text = nil
			textView.textColor = UIColor.black
		}
	}

	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.isEmpty {
			textView.text = self.placeholder
			textView.textColor = UIColor.lightGray
		}
	}
}
