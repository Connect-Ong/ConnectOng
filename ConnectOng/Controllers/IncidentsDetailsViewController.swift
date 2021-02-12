//
//  IncidentsDetailsViewController.swift
//  ConnectOng
//
//  Created by Alley Pereira on 20/08/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

class IncidentsDetailsViewController: UIViewController {
    
    var imageLoader = ImageLoader.singleton
    
    var incident: Incident!
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var titleDetailLabel: UILabel!
    @IBOutlet weak var descriptionDetailLabel: UILabel!
    @IBOutlet weak var valueDetailLabel: UILabel!
    
	@IBOutlet weak var callButton: UIButton!
	@IBOutlet weak var whatsappButton: UIButton!

	@IBOutlet weak var callForActionLabel: UILabel!

	@IBAction func makeCallAction(_ sender: Any) {
		print("Make Call 📞")
		if let url = URL(string: "tel://\(self.incident.whatsapp)"),
		   UIApplication.shared.canOpenURL(url) {
			if #available(iOS 10, *) {
				UIApplication.shared.open(url, options: [:], completionHandler:nil)
			} else {
				UIApplication.shared.openURL(url)
			}
		}
	}

    @IBAction func contactWhatsppButtonPressed(_ sender: UIButton) {
        var contact = self.incident.whatsapp
        contact = contact.addingPercentEncoding(withAllowedCharacters: (NSCharacterSet.urlQueryAllowed))!
        
        let message = "Olá, achei vocês pelo App Connect ONG e gostaria de ajudar 😊"
        
        var whatsappRequest = URLComponents()
        whatsappRequest.scheme = "whatsapp"
        whatsappRequest.host = "send"
        whatsappRequest.queryItems = [
            URLQueryItem(name: "phone", value: "+55\(contact)"),
            URLQueryItem(name: "text", value: message)
        ]
        
        if let whatsappURL = whatsappRequest.url { //"whatsapp://send?phone=+55\(contact)&text=\(message)"
            if UIApplication.shared.canOpenURL(whatsappURL) {
                UIApplication.shared.open(whatsappURL)//openURL(whatsappURL! as URL)
            } else {
                let alertController = UIAlertController(title: "Não foi possível executar essa ação",
                                                        message: "Você precisa instalar o Whatsapp nos seu dispositivo",
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
//                print("Provavelmente sem whattsApp")
            }
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descriptionDetailLabel.text = incident.description
        self.titleDetailLabel.text = incident.title
        //        self.detailImageView.image = incident.
		if Double(incident.value)! != 0 {
			self.valueDetailLabel.text = "Valor a ser arrecadado R$ \(incident.value)"
		} else {
			self.valueDetailLabel.text = "Miaudote ❤️🐾"
			self.callForActionLabel.text = "Precisamos da sua ajuda!"
		}


		if #available(iOS 13.0, *) {
			let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold, scale: .large)
			let largeBoldDoc = UIImage(systemName: "phone", withConfiguration: largeConfig)

			callButton.setImage(largeBoldDoc, for: .normal)
		}

		whatsappButton.contentMode = .scaleAspectFit
        
        DispatchQueue.global().async {
            //            let url: URL? = URL(string: self.incident.imgURL)
            //            let imageData = try? Data(contentsOf: url!)
            //            let img = UIImage(data: imageData!)
            //            DispatchQueue.main.async {
            //                self.detailImageView.image = img
            self.imageLoader.obtainImage(imagePath: self.incident.imgURL) { (img) in
                self.detailImageView.image = img
            }
            //            }
        }
    }
}
