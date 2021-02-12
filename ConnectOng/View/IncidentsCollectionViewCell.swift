//
//  IncidentsCollectionViewCell.swift
//  ConnectOng
//
//  Created by Alley Pereira on 19/08/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

class IncidentsCollectionViewCell: UICollectionViewCell {
    
    var imageLoader = ImageLoader.singleton

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ongLabel: UILabel!

    static let identifier = "IncidentsCollectionViewCell"

    var url: URL? {
        didSet {
            self.imageLoader.obtainImage(imagePath: url!.absoluteString) { (img) in
                self.pictureImageView.image = img
            }
        }
    }
    
    override func awakeFromNib() { 
        super.awakeFromNib()
		self.clipsToBounds = false
		self.layer.masksToBounds = false
		self.applyShadow()
    }

    override func prepareForReuse() {
		super.prepareForReuse()
		self.pictureImageView.image = nil
    }

	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
		longPressRecognizer.minimumPressDuration = 0.2
		self.addGestureRecognizer(longPressRecognizer)
	}

	@objc func longPressed(sender: UILongPressGestureRecognizer) {
		if sender.state == .began {
			print("TOUCH")
			let animationView = AnimationView(image: self.pictureImageView.image)
			UIApplication.shared.keyWindow?.addSubview(animationView)
		} else if sender.state == .ended {
			print("BYE")
			UIApplication.shared.keyWindow?.subviews.last?.removeFromSuperview()
		}
	}

}

extension UIView {
    func applyShadow() {
        //Criando e aplicando a shadow
        self.layer.cornerRadius = 5.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.5, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.3
		self.layer.shouldRasterize = true
		self.layer.rasterizationScale = UIScreen.main.scale
    }
}
