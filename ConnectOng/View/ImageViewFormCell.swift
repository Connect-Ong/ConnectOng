//
//  ImageViewFormCell.swift
//  ConnectOng
//
//  Created by Alley Pereira on 11/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import UIKit

class ImageViewFormCell: UITableViewCell {

	static let cellIdentifier: String = "ImageViewFormCell"

	lazy var pictureView: UIImageView = {
		let pictureView = UIImageView(frame: .zero)
		pictureView.contentMode = .scaleAspectFill
		pictureView.clipsToBounds = true
		pictureView.translatesAutoresizingMaskIntoConstraints = false
		return pictureView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.addSubview(pictureView)
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	func setupConstraints() {
		NSLayoutConstraint.activate([
			pictureView.topAnchor.constraint(equalTo: self.topAnchor),
			pictureView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			pictureView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			pictureView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
			pictureView.heightAnchor.constraint(equalToConstant: 150)
		])
	}

}
