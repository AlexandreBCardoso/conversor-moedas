//
//  ConversorVC.swift
//  Conversor Moedas
//
//  Created by Alexandre Cardoso on 21/04/21.
//

import UIKit

enum Segue: String {
	case listaMoeda = "segueListaMoeda"
}

class ConversorVC: UIViewController {
	
	// MARK: - IBOutlet
	@IBOutlet weak var backView: UIView!
	@IBOutlet weak var moedaOriLabel: UILabel!
	@IBOutlet weak var valueTextField: UITextField!
	@IBOutlet weak var moedaDesLabel: UILabel!
	@IBOutlet weak var valueConvertidoLabel: UILabel!
	@IBOutlet weak var convertButton: UIButton!
	
	// MARK: - Variable
	private let viewModel: ConversorVM = ConversorVM()
	
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupLayout()
		setupDelegate()
		setupTextField()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segue.listaMoeda.rawValue {
			if let listaMoedaVC = segue.destination as? ListagemMoedasVC {
				listaMoedaVC.delegate = self
				listaMoedaVC.setupViewModel(value: sender as? Int)
			}
		}
	}
	
	
	// MARK: - Function
	private func setupLayout() {
		self.backView.layer.cornerRadius = 15
		self.convertButton.layer.cornerRadius = 10
		self.convertButton.isHidden = true
	}
	
	private func setupDelegate() {
		self.valueTextField.delegate = self
		self.viewModel.delegate = self
	}
	
	private func setupTextField() {
		let toolbar = UIToolbar()
		toolbar.barStyle = .default
		toolbar.isTranslucent = true
		toolbar.tintColor = .blue
		toolbar.backgroundColor = .white
		toolbar.sizeToFit()
		
		let buttonOK = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(actionButtonOK))
		let buttonSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		
		toolbar.setItems([buttonSpace, buttonOK], animated: true)
		toolbar.isUserInteractionEnabled = true
		
		self.valueTextField.inputAccessoryView = toolbar
	}
	
	@objc
	func actionButtonOK() {
		self.valueTextField.resignFirstResponder()
		if self.valueTextField.text != "" {
			self.convertButton.isHidden = false
		}
	}
	
	
	// MARK: - IBAction
	@IBAction func tappedTrocaMoedaButton(_ sender: UIButton) {
		self.valueConvertidoLabel.text = "0.00"
		performSegue(withIdentifier: Segue.listaMoeda.rawValue, sender: sender.tag)
	}
	
	@IBAction func tappedConverterButton(_ sender: UIButton) {
		
		self.viewModel.getQuotes(value: valueTextField.text ?? "",
										 origin: self.moedaOriLabel.text ?? "",
										 destiny: self.moedaDesLabel.text ?? "")
	}
	
		
}


// MARK: - Extension
extension ConversorVC: ListagemMoedasVCProtocol {
	
	func didSelectedCurrrencyOrigem(value: Currency?) {
		self.moedaOriLabel.text = value?.code
	}
	
	func didSelectedCurrrencyDestino(value: Currency?) {
		self.moedaDesLabel.text = value?.code
	}
	
}


// MARK: - Extension TextField
extension ConversorVC: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
}


extension ConversorVC: ConversorVMProtocol {
	
	func successCalculatingExchangeValue(value: String) {
		DispatchQueue.main.async {
			self.valueConvertidoLabel.text = value
		}
	}
	
}
