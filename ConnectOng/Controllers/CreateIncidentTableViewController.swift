//
//  CreateIncidentTablewViewController.swift
//  ConnectOng
//
//  Created by Alley Pereira on 08/02/21.
//  Copyright © 2021 Alley Pereira. All rights reserved.
//

import UIKit
import CloudKit
//swiftlint:disable cyclomatic_complexity function_body_length
class CreateIncidentTableViewController: UITableViewController {

	private var image: UIImage? {
		didSet {
			self.tableView.reloadData()
		}
	}

	weak var delegate: CreateIncidentDelegate?

	lazy var imagePicker: ImagePicker = {
		ImagePicker(presentationController: self, delegate: self)
	}()

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
		if #available(iOS 13.0, *) {
			overrideUserInterfaceStyle = .light
		} else {
			// Fallback on earlier versions
		}

		setupNavigationItem()

		// dismiss keyboard
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tableView.addGestureRecognizer(tapGesture)

		tableView.register(TextFieldFormCell.self, forCellReuseIdentifier: TextFieldFormCell.cellIdentifier)
		tableView.register(TextViewFormCell.self, forCellReuseIdentifier: TextViewFormCell.cellIdentifier)
		tableView.register(SubmitButtonFormCell.self, forCellReuseIdentifier: SubmitButtonFormCell.cellIdentifier)
		tableView.register(ImagePickerFormCell.self, forCellReuseIdentifier: ImagePickerFormCell.cellIdentifier)
		tableView.register(ImageViewFormCell.self, forCellReuseIdentifier: ImageViewFormCell.cellIdentifier)
	}

	func setupNavigationItem() {
		navigationItem.title = "Novo Caso"

		//RightBarButton
		let rightBarButton = UIBarButtonItem(
			title: "Criar",
			style: .done,
			target: self,
			action: #selector(didTapRegister)
		)
		rightBarButton.tintColor = UIColor(named: "redCustomized")

		//LeftBarButton
		let leftBarButton = UIBarButtonItem(
			title: "Cancelar",
			style: .plain,
			target: self,
			action: #selector(didTapCancel)
		)
		leftBarButton.tintColor = UIColor(named: "redCustomized")

		navigationItem.rightBarButtonItem = rightBarButton
		navigationItem.leftBarButtonItem = leftBarButton
	}

	@objc func didTapRegister() {
		submitImageCloudkit()
	}

	@objc func didTapCancel() {
		self.dismiss(animated: true, completion: nil)
	}

	func submitImageCloudkit() {
		let imageName = UUID().uuidString
		if let data = image?.jpegData(compressionQuality: 0.5),
		   let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
			let imageURL = documentsURL.appendingPathComponent(imageName+".jpg")

			do {
				try data.write(to: imageURL)

				//Salvar no CloudKit
				let newImage = Images(id: CKRecord.ID(), imageURLAsset: CKAsset(fileURL: imageURL))
				CloudKitModel.current.saveImage(image: newImage) { (result) in
					switch result {
					case .success(let record):
//						print(record.description)

//						print("Record ID aqui: \(record.recordID.recordName)")
						self.createIncidentSubmission(imageName: record.recordID.recordName)

					case .failure(let error):
						print(error.localizedDescription)
					}
				}

			} catch {
				print(error.localizedDescription)
			}
		}
	}

	func createIncidentSubmission(imageName: String) {

		// MARK: Acessando cada celula do formulario
		//		tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ImagePickerFormCell
		guard let titleCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? TextFieldFormCell,
			  let descriptionCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? TextViewFormCell,
			  //			  let cityCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? TextFieldFormCell,
			  let valueCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? TextFieldFormCell,
			  let ongIDCell = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as? TextFieldFormCell else {
			return
		}

		// MARK: Chamar o Back via Networking
		Networking.createIncidentRequest(
			ongID: ongIDCell.textFieldForm.text,
			title: titleCell.textFieldForm.text,
			description: descriptionCell.textViewForm.text,
			value: valueCell.textFieldForm.text,
			imgUrl: imageName,
			//			city: cityCell.textFieldForm.text ?? "",
			completion: { [weak self] in
				self?.dismiss(animated: true, completion: nil)
				self?.delegate?.updateList()
			}
		)
	}

}

extension CreateIncidentTableViewController: ImagePickerDelegate {
	func didSelect(image: UIImage?) {
		self.image = image
	}
}

// MARK: - UITablewViewDelegate + UItableViewDatasource

extension CreateIncidentTableViewController {

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		dismissKeyboard()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		// MARK: - GAMBIARRA 💩
		switch indexPath.row {
		case 0:

			if let image = self.image {

				let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: ImageViewFormCell.cellIdentifier, for: indexPath)
				guard let cell = dequeuedCell as? ImageViewFormCell else { return UITableViewCell() }
				cell.pictureView.image = image
				return cell

			} else {

				let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: ImagePickerFormCell.cellIdentifier, for: indexPath)
				guard let cell = dequeuedCell as? ImagePickerFormCell else { return UITableViewCell() }
				cell.takePictureHandler = { [weak self] in
					self?.imagePicker.present(from: cell.imagePickerButton)
				}
				return cell

			}

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
		//		case 3:
		//			let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: TextFieldFormCell.cellIdentifier, for: indexPath)
		//			guard let cell = dequeuedCell as? TextFieldFormCell else { return UITableViewCell() }
		//			cell.setupTextValue(title: "Cidade", placeholder: "Cidade do caso", keyboardType: .asciiCapable)
		//			return cell
		case 3:
			let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: TextFieldFormCell.cellIdentifier, for: indexPath)
			guard let cell = dequeuedCell as? TextFieldFormCell else { return UITableViewCell() }
			cell.setupTextValue(title: "Valor", placeholder: "Caso adoção, coloque 0", keyboardType: .numberPad)
			return cell
		case 4:
			let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: TextFieldFormCell.cellIdentifier, for: indexPath)
			guard let cell = dequeuedCell as? TextFieldFormCell else { return UITableViewCell() }
			cell.setupTextValue(title: "Ong ID", placeholder: "Digite seu OngID", keyboardType: .numberPad)
			return cell
		case 5:
			let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: SubmitButtonFormCell.cellIdentifier, for: indexPath)
			guard let cell = dequeuedCell as? SubmitButtonFormCell else { return UITableViewCell() }
			cell.submitHandler = { [weak self] in
				self?.submitImageCloudkit()
			}
			return cell


		default:
			return UITableViewCell()
		}
	}
	

	// altura da celula
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.row {
		case 0:
			return image != nil ? UITableView.automaticDimension : 100
		case 2:
			return 140
		case 6:
			return 110
		default:
			return 100
		}
	}
}
