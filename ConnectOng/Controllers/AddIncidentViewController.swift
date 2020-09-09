//
//  AddIncidentViewController.swift
//  ConnectOng
//
//  Created by Alley Pereira on 20/08/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

class AddIncidentViewController: UIViewController {
    
    
//    func createIncidentRequest() {
//        guard let url = URL(string: Routes.cadastrar) else { return }
//        var urlRequest = URLRequest(url: url)
//        var request = urlRequest
//
//
//        //        guard let requestUrl = url else { fatalError() }
//        //
//        //        var urlRequest = URLRequest(url: url!)
//        //        var request = URLRequest(url: requestUrl)
//
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("ongId", forHTTPHeaderField: "Authorization") // passar o OngId
//
//        //        let jsonData = try JSONEncoder().encode(incidente)
//        URLSession.shared.dataTask(with: request, completionHandler: {
//            data, response, error in
//            if let  error = error {
//                print("Erro na requisicao"+error.localizedDescription)
//            }
//            guard let response = response as? HTTPURLResponse else {
//                print("Response nao veio HTTP")
//                return
//            }
//            print("Status Code: \(response.statusCode)")
//            print(data)
//        }).resume()
//
//        //        Dispatch.DispatchQueue.main.async {
//        //            <#code#>
//        //        }
//    }
    
    @IBAction func cancelarAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func concluidoAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        // criar novo caso no back
//        createIncidentRequest()
    }
    
    @IBAction func createIncidentAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        // criar novo caso no back
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // clique na view
        //        print("\nTaokeys")
        self.view.endEditing(true) // fazer o teclado baixar ao clicar na view
    }
}
