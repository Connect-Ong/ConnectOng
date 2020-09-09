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
        //        self.contentView.layer.masksToBounds = false
        self.layer.masksToBounds = false
        self.applyShadow()
    }
    
}

extension UIView {
    func applyShadow() {
        //Criando e aplicando a shadow
        self.layer.cornerRadius = 20.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.5, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.3
    }
}
