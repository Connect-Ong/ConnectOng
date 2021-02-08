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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IncidentDetailSegue" {
            if let incidentDetail = segue.destination as? IncidentsDetailsViewController,
               let selectedIncident = sender as? Incident {
                incidentDetail.incident = selectedIncident
            }
        } else if segue.identifier == "AddIncidentSegue" {
            if let navigation = segue.destination as? UINavigationController,
               let addIncident = navigation.viewControllers.first as? AddIncidentViewController {
                addIncident.delegate = self
            }
        }
        
    }
    
	var incidents = [Incident]() {
		//após que o incidents ter seu valor alterado, roda o codigo que ta aqui dentro
		didSet {

			//acessa cada incident
			for (index, incident) in incidents.enumerated() {

				//faz download da imagem a partir do imgURL do incident da iteracao
				ImageLoader.singleton.obtainImage(imagePath: incident.imgURL) { (image) in

					//popula dicionario pictures com a imagem baixada
					// exemplo: incident da iteracao 0 popula o dicionario com:
					// {
					//	  0: imagem baixada da imgURL do incident[0]
					// }
					self.pictures[index] = image

					// Na main, regacarrega collectionView com a imagem recém baixada
					DispatchQueue.main.async {
						self.collectionView.reloadData()
					}
				}
			}
		}
	}

	// Dicionario que guarda imgURL baixadas de cada Incident.
	// populado no didSet do incidents.
	var pictures = [Int: UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.layer.masksToBounds = false
        self.collectionView.register(UINib(nibName: "IncidentsCollectionViewCell", bundle: .main),
                                     forCellWithReuseIdentifier: IncidentsCollectionViewCell.identifier)
        
        APIManager.getIncidents(completion: { incidents in
            self.incidents = incidents
            
            IncidentJSONManager.createIncidentList(arrayIncident: incidents)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        
        self.incidents = IncidentJSONManager.readIncidentList()
        self.collectionView.reloadData()
    }
    
}


//swiftlint:disable line_length
extension IncidentListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return incidents.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IncidentsCollectionViewCell.identifier,
                                                         for: indexPath) as? IncidentsCollectionViewCell {
            cell.pictureImageView.backgroundColor = UIColor.random()
            
            cell.cityLabel.text = incidents[indexPath.row].city
			cell.titleLabel.text = incidents[indexPath.row].title
            cell.ongLabel.text = "Ong \(incidents[indexPath.row].name)"
            //            print(incidents[indexPath.row].imgURL)
            
            // carregar imagem
//            let imageURL = incidents[indexPath.row].imgURL
//            cell.url = URL(string: imageURL)
			if let image = pictures[indexPath.row] {
				cell.pictureImageView.image = image
			}

            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "IncidentDetailSegue", sender: incidents[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
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

extension IncidentListViewController: AddIncidentDelegate {
    func updateList() {
        APIManager.getIncidents(completion: { incidents in
            self.incidents = incidents
            
            IncidentJSONManager.createIncidentList(arrayIncident: incidents)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}
