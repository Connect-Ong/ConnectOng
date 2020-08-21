//
//  ViewController.swift
//  ConnectOng
//
//  Created by Alley Pereira on 19/08/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

class IncidentListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func createIncidentAction(_ sender: Any) {
        self.performSegue(withIdentifier: "AddIncidentSegue", sender: nil)
    }
    
    var incidents = [Incident]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.layer.masksToBounds = false
        self.collectionView.register(UINib(nibName: "IncidentsCollectionViewCell", bundle: .main),
                                     forCellWithReuseIdentifier: IncidentsCollectionViewCell.identifier)
        
        APIManager.getIncidents(completion: { incidents in
            self.incidents = incidents
            print(self.incidents.count)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
//       var guardar = APIManager()
//        guardar.getIncidents()
        
    }

}

extension IncidentListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return incidents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IncidentsCollectionViewCell.identifier,
                                                         for: indexPath) as? IncidentsCollectionViewCell {
            cell.pictureImageView.backgroundColor = UIColor.random()
            
            cell.cityLabel.text = incidents[indexPath.row].city
            cell.titleLabel.text = incidents[indexPath.row].title
            cell.ongLabel.text = incidents[indexPath.row].name
//            print(incidents[indexPath.row].imgURL)
            
            // carregar imagem
            let imageURL = incidents[indexPath.row].imgURL
            let imageData = try? Data(contentsOf: URL(string: imageURL)!)
            
            // criando imagem
            let imagem = UIImage(data: imageData!)
            cell.pictureImageView.image = imagem
            
            
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        self.performSegue(withIdentifier: "IncidentDetailSegue", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 280)
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
