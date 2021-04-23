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
	@IBOutlet weak var moedaOriLabel: UILabel!
	@IBOutlet weak var valueTextField: UITextField!
	@IBOutlet weak var moedaDesLabel: UILabel!
	@IBOutlet weak var valueConvertidoLabel: UILabel!
	
	// MARK: - Variable
	private let viewModel: ConversorVM = ConversorVM()
	
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.viewModel.delegate = self
		
		configureTextField()
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
	private func configureTextField() {
		self.valueTextField.delegate = self
	}
	
	
	// MARK: - IBAction
	@IBAction func tappedTrocaMoedaButton(_ sender: UIButton) {
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
