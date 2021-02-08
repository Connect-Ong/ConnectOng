//
//  CreateIncidentTablewViewController.swift
//  ConnectOng
//
//  Created by Alley Pereira on 08/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import UIKit

class CreateIncidentTablewViewController: UITableViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

// MARK: - UITablewViewDelegate + UItableViewDatasource

extension CreateIncidentTablewViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 10
	}
}
