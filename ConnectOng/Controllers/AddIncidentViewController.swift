//
//  AddIncidentViewController.swift
//  ConnectOng
//
//  Created by Alley Pereira on 20/08/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//
//
//import UIKit
//
//protocol AddIncidentDelegate: class {
//    func updateList()
//}
//
//
//class AddIncidentViewController: UIViewController {
//
//
//    @IBOutlet weak var tituloDoCaso: UITextField!
//    @IBOutlet weak var descricao: UITextField!
//    @IBOutlet weak var valor: UITextField!
//    @IBOutlet weak var ongID: UITextField!
//    @IBOutlet weak var imageURL: UITextField!
//
//    weak var delegate: AddIncidentDelegate?
//
//    func createIncidentRequest() {
//        guard let url = URL(string: Routes.rootURL+Routes.cadastrar) else { return }
//		let urlRequest = URLRequest(url: url)
//        var request = urlRequest
//
//        print(url)
//
//
//        //        guard let requestUrl = url else { fatalError() }
//        //
//        //        var urlRequest = URLRequest(url: url!)
//        //        var request = URLRequest(url: requestUrl)
//
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue(ongID.text!, forHTTPHeaderField: "Authorization") // passar o OngId
//
//         /*
//            Fazer um JSON que vai ser mandado na requisicao;
//            transfrmar ele em Data e guardar em uma variavel
//            Atribuir o Data ao HTTP Body da request
//
//         {
//             "title": "Gatinho precisando de um lar",
//             "description": "Gatinho para adoção",
//             "value": 0,
//             "img_url": "http://imagem.com/image.png"
//         }
//          */
//        let jsonDict: [String: Any] = [
//            "title": tituloDoCaso.text!,
//            "description": descricao.text!,
//            "value": Double(valor.text!)!,
//            "img_url": imageURL.text!,
//            "sensible_content": false
//        ]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: [])
//        request.httpBody = jsonData
//
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
//
//            DispatchQueue.main.async {
//            self.delegate?.updateList()
//            }
//
//        }).resume()
//
//
//    }
//
//    @IBAction func cancelarAction(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//        dismiss(animated: true) {
//            return
//        }
//    }
//
//    @IBAction func concluidoAction(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//        // criar novo caso no back
//        createIncidentRequest()
//
//    }
//
//    @IBAction func createIncidentAction(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//        // criar novo caso no back
//        createIncidentRequest()
//        guard let titulo = tituloDoCaso.text else {
//            print("Digite o titulo")
//            return
//        }
//        let titulo = tituloDoCaso.text
//        print(titulo)
//        self.createIncidentRequest()
//
//        tituloDoCaso.addTarget(self, action: #selector, for: )
//
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // clique na view
//        //        print("\nTaokeys")
//        self.view.endEditing(true) // fazer o teclado baixar ao clicar na view
//    }
//}
