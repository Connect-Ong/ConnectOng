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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
