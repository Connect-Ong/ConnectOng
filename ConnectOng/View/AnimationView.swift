//
//  AnimationView.swift
//  ConnectOng
//
//  Created by Alley Pereira on 11/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import UIKit

class AnimationView: UIView {

	lazy var backgroundOverlay: UIView = {
		let animationView = UIView(frame: UIScreen.main.bounds)
		animationView.backgroundColor = .black
		animationView.alpha = 0.3
		return animationView
	}()

	lazy var polaroidView: UIView = {

		let frame = CGRect(
			x: 0,
			y: 0,
			width: UIScreen.main.bounds.width - 25,
			height: UIScreen.main.bounds.height/2.2
		)

		let polaroidView = UIView(frame: frame)
		polaroidView.backgroundColor = .white
		polaroidView.center = self.center
		polaroidView.layer.cornerRadius = 5
		return polaroidView
	}()

	lazy var imageView: UIImageView = {
		let frame = CGRect(
			x: 0,
			y: 0,
			width: UIScreen.main.bounds.width - 60,
			height: UIScreen.main.bounds.height/3
		)
		let imageView = UIImageView(frame: frame)
		imageView.center = CGPoint(x: self.center.x, y: self.polaroidView.frame.minY + (imageView.frame.height/1.75))
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = UIColor.random()
		imageView.layer.cornerRadius = 5
		imageView.clipsToBounds = true
		return imageView
	}()

	let centerOfScreen = CGPoint(
		x: UIScreen.main.bounds.midX,
		y: UIScreen.main.bounds.minY
	)

	init(image: UIImage?) {
		super.init(frame: UIScreen.main.bounds)

		self.imageView.image = image

		animation()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.addSubview(backgroundOverlay)
		self.addSubview(polaroidView)
		self.addSubview(imageView)
	}

	func animation() {

		UIView.animate(
			withDuration: 0.75,
			delay: 0,
			usingSpringWithDamping: 0.7,
			initialSpringVelocity: 1,
			options: .curveEaseOut,
			animations: {
				self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
				self.imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
				self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)

				self.polaroidView.transform = CGAffineTransform(scaleX: 1, y: 1)
				self.polaroidView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
				self.polaroidView.transform = CGAffineTransform(scaleX: 1, y: 1)
			}
		)
	}
}
