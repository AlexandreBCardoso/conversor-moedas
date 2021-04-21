//
//  ListagemMoedasVC.swift
//  Conversor Moedas
//
//  Created by Alexandre Cardoso on 21/04/21.
//

import UIKit

class ListagemMoedasVC: UIViewController {
	
	// MARK: - IBOutlet
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: - Variable
	private let viewModel: ListagemMoedasVM = ListagemMoedasVM()
	
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureTableView()
		loadListCurrency()
	}
	
	
	// MARK: - Function
	private func configureTableView() {
		self.tableView.dataSource = self
		self.tableView.delegate = self
	}
	
	private func loadListCurrency() {
		self.viewModel.loadListCurrency { (success) in
			if success {
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			} else {
				print("===>> erro no carregamento de Lista de Moedas")
			}
		}
	}
		
}


// MARK: - Extension TableView
extension ListagemMoedasVC: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.numberOfRows()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let currency = self.viewModel.getCurrency(indexPath: indexPath)
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		cell.textLabel?.text = currency.code
		cell.detailTextLabel?.text = currency.name
		
		return cell
	}

}
