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
        self.valueDetailLabel.text = "R$ \(incident.value)"
        
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
