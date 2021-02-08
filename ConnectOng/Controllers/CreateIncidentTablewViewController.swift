//
//  CreateIncidentTablewViewController.swift
//  ConnectOng
//
//  Created by Alley Pereira on 08/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import UIKit

class CreateIncidentTablewViewController: UITableViewController {

	init() {
		super.init(style: .grouped)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(TextFieldFormCell.self, forCellReuseIdentifier: TextFieldFormCell.cellIdentifier)
	}
}

// MARK: - UITablewViewDelegate + UItableViewDatasource

extension CreateIncidentTablewViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: TextFieldFormCell.cellIdentifier)

		guard let cell = dequeuedCell as? TextFieldFormCell else {
			return UITableViewCell()
		}
		
		cell.backgroundColor = .blue

		return cell
	}
	

	// altura
//	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		return 10
//	}
}
