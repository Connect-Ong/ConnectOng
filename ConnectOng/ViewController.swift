//
//  ViewController.swift
//  ConnectOng
//
//  Created by Alley Pereira on 19/08/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName: "IncidentsCollectionViewCell", bundle: .main),
                                     forCellWithReuseIdentifier: IncidentsCollectionViewCell.identifier)
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IncidentsCollectionViewCell.identifier,
                                                         for: indexPath) as? IncidentsCollectionViewCell {
            cell.pictureImageView.backgroundColor = UIColor.random()
            return cell
        }
        return UICollectionViewCell()
    }

}


extension UIColor {
    static func random() -> UIColor {
        return UIColor.init(red: CGFloat.random(in: 0...1),
                            green: CGFloat.random(in: 0...1),
                            blue: CGFloat.random(in: 0...1),
                            alpha: 1)
    }
}
