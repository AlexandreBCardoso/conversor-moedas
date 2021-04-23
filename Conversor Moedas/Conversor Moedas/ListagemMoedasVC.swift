//
//  ListagemMoedasVC.swift
//  Conversor Moedas
//
//  Created by Alexandre Cardoso on 21/04/21.
//

import UIKit


protocol ListagemMoedasVCProtocol: class {
	func didSelectedCurrrencyOrigem(value: Currency?)
	func didSelectedCurrrencyDestino(value: Currency?)
}


class ListagemMoedasVC: UIViewController {
	
	// MARK: - IBOutlet
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	// MARK: - Variable
	private let viewModel: ListagemMoedasVM = ListagemMoedasVM()
	weak var delegate: ListagemMoedasVCProtocol?
	
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.searchBar.delegate = self
		self.viewModel.delegate = self
		
		configureTableView()
		loadListCurrency()
	}
	
	
	// MARK: - Function
	private func configureTableView() {
		self.tableView.dataSource = self
		self.tableView.delegate = self
	}
	
	private func loadListCurrency() {
		self.viewModel.loadListCurrency()
	}
	
	func setupViewModel(value: Int?) {
		self.viewModel.setTagButton(value: value)
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
		
		cell.textLabel?.text = currency?.code
		cell.detailTextLabel?.text = currency?.name
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.viewModel.didSelectedCurrency(indexPath: indexPath)
	}
	
}


// MARK: - Extension SearchBar
extension ListagemMoedasVC: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		self.viewModel.searchBar(textDidChange: searchText)
		self.tableView.reloadData()
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		self.viewModel.isActiveSearchBar(value: true)
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		self.viewModel.isActiveSearchBar(value: false)
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.viewModel.isActiveSearchBar(value: false)
		searchBar.resignFirstResponder()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.viewModel.searchBarActive = false
		searchBar.resignFirstResponder()
	}
	
}


// MARK: - Extension ViewModel Delegate
extension ListagemMoedasVC: ListagemMoedasVMDelegate {
	
	func didSelectecCurrencyOrigin(value: Currency?) {
		self.delegate?.didSelectedCurrrencyOrigem(value: value)
		self.navigationController?.popViewController(animated: true)
	}
	
	func didSelectecCurrencyDestiny(value: Currency?) {
		self.delegate?.didSelectedCurrrencyDestino(value: value)
		self.navigationController?.popViewController(animated: true)
	}
	
	
//	func didSelectecCurrency(value: Currency?) {
//		//		if buttonTag == 1 {
//		//			self.delegate?.didSelectedCurrrencyOrigem(value: value)
//		//		} else {
//		//			self.delegate?.didSelectedCurrrencyDestino(value: value)
//		//		}
//		//		self.navigationController?.popViewController(animated: true)
//	}
	
	func success() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
	
	func failure(error: Error?) {
		print("===>> Error: \(String(describing: error?.localizedDescription))")
	}
	
}
