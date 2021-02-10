//
//  CreateIncidentTablewViewController.swift
//  ConnectOng
//
//  Created by Alley Pereira on 08/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import UIKit
//swiftlint:disable cyclomatic_complexity
class CreateIncidentTablewViewController: UITableViewController {

	init() {
		super.init(style: .grouped)
		tableView.separatorStyle = .none //linhas da tableView
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// dismiss keyboard
	override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		dismissKeyboard()
	}

	@objc func dismissKeyboard() {
		 self.view.endEditing(true)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// dismiss keyboard
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tableView.addGestureRecognizer(tapGesture)

		tableView.register(TextFieldFormCell.self, forCellReuseIdentifier: TextFieldFormCell.cellIdentifier)
		tableView.register(TextViewFormCell.self, forCellReuseIdentifier: TextViewFormCell.cellIdentifier)
		tableView.register(SubmitButtonFormCell.self, forCellReuseIdentifier: SubmitButtonFormCell.cellIdentifier)
		tableView.register(ImagePickerFormCell.self, forCellReuseIdentifier: ImagePickerFormCell.cellIdentifier)
	}
}

// MARK: - UITablewViewDelegate + UItableViewDatasource

extension CreateIncidentTablewViewController {

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		dismissKeyboard()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 7 
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		// MARK: - GAMBIARRA 💩
		switch indexPath.row {
		case 0:
			let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: ImagePickerFormCell.cellIdentifier, for: indexPath)
			guard let cell = dequeuedCell as? ImagePickerFormCell else { return UITableViewCell() }
			return cell
		case 1:
			let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: TextFieldFormCell.cellIdentifier, for: indexPath)
			guard let cell = dequeuedCell as? TextFieldFormCell else { return UITableViewCell() }
			cell.setupTextValue(title: "Título do caso", placeholder: "Máximo 50 caracteres", keyboardType: .asciiCapable)
			return cell
		case 2:
			let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: TextViewFormCell.cellIdentifier, for: indexPath)
			guard let cell = dequeuedCell as? TextViewFormCell else { return UITableViewCell() }
			cell.setupTextValue(title: "Descrição", placeholder: "Máximo 200 caracteres")
			return cell
		case 3:
			let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: TextFieldFormCell.cellIdentifier, for: indexPath)
			guard let cell = dequeuedCell as? TextFieldFormCell else { return UITableViewCell() }
			cell.setupTextValue(title: "Cidade", placeholder: "Cidade do caso", keyboardType: .asciiCapable)
			return cell
		case 4:
			let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: TextFieldFormCell.cellIdentifier, for: indexPath)
			guard let cell = dequeuedCell as? TextFieldFormCell else { return UITableViewCell() }
			cell.setupTextValue(title: "Valor", placeholder: "Caso adoção, coloque 0", keyboardType: .numberPad)
			return cell
		case 5:
			let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: TextFieldFormCell.cellIdentifier, for: indexPath)
			guard let cell = dequeuedCell as? TextFieldFormCell else { return UITableViewCell() }
			cell.setupTextValue(title: "Ong ID", placeholder: "Digite seu OngID", keyboardType: .numberPad)
			return cell
		case 6:
			let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: SubmitButtonFormCell.cellIdentifier, for: indexPath)
			guard let cell = dequeuedCell as? SubmitButtonFormCell else { return UITableViewCell() }
//			cell.createButtonWasTapped.self = indexPath.row
			//			cell.setupTextValue(title: "Ong ID", placeholder: "Digite seu OngID")
//						dequeuedCell.callback = { cell in
//							  let actualIndexPath = tableView.indexPath(for: cell)!
//							  print("Button pressed", actualIndexPath)
			return cell


		default:
			return UITableViewCell()
		}
	}
	

	// altura da celula
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 2 {
			return 140
		}
		return 100
	}
}
