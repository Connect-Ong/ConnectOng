//
//  AddIncidentViewController.swift
//  ConnectOng
//
//  Created by Alley Pereira on 20/08/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

class AddIncidentViewController: UIViewController {

    
    @IBAction func cancelarAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func concluidoAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        // criar novo caso no back
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
