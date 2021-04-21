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
	
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	
	// MARK: - IBAction
	@IBAction func tappedTrocaMoedaButton(_ sender: UIButton) {
		performSegue(withIdentifier: Segue.listaMoeda.rawValue, sender: nil)
	}
	
	@IBAction func tappedConverterButton(_ sender: UIButton) {
	}
	
		
}
