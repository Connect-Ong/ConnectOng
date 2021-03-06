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
		let createIncident = CreateIncidentTableViewController()
		createIncident.delegate = self
		let navigation = UINavigationController(rootViewController: createIncident)
		self.navigationController?.present(navigation, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IncidentDetailSegue" {
            if let incidentDetail = segue.destination as? IncidentsDetailsViewController,
               let selectedIncident = sender as? Incident {
                incidentDetail.incident = selectedIncident
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
        
        Networking.getIncidents(completion: { incidents in
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return UIDevice.current.sizeForCollectionCell()
    }

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}
    
}

extension IncidentListViewController: CreateIncidentDelegate {
    func updateList() {
        Networking.getIncidents(completion: { incidents in
            self.incidents = incidents

            IncidentJSONManager.createIncidentList(arrayIncident: incidents)

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}
