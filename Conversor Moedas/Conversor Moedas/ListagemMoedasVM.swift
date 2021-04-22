//
//  ListagemMoedasVM.swift
//  Conversor Moedas
//
//  Created by Alexandre Cardoso on 21/04/21.
//

import Foundation

protocol ListagemMoedasVMDelegate: class {
	func success()
	func failure(error: Error?)
	func didSelectecCurrency(value: Currency?)
}

class ListagemMoedasVM {
	
	// MARK: - Variable
	private let listMoedaWorker: ListagemMoedasWorker = ListagemMoedasWorker()
	private var listCurrency: ListCurrency?
//	private var currencies: [Currency] = [Currency]()
	private var currenciesFiltered: [Currency] = [Currency]()
	var searchBarActive: Bool = false
	weak var delegate: ListagemMoedasVMDelegate?
	
	
	// MARK: - Function
	func loadListCurrency() {
		listMoedaWorker.loadListCurrency { (currency, error) in
			if let _currency = currency {
				self.listCurrency = _currency
				self.delegate?.success()
			} else {
				self.delegate?.failure(error: error)
			}
		}
	}
	
	func numberOfRows() -> Int {
		if self.searchBarActive {
			return self.currenciesFiltered.count
		} else {
			return self.listCurrency?.currenciesLoad?.count ?? 0
		}
	}
	
	func getCurrency(indexPath: IndexPath) -> Currency? {
		if self.searchBarActive {
			return self.currenciesFiltered[indexPath.row]
		} else {
			return (self.listCurrency?.currenciesLoad?[indexPath.row])!
		}
	}
	
	func isActiveSearchBar(value: Bool) {
		self.searchBarActive = value
	}
	
	func searchBar(textDidChange searchText: String) {
		
		self.currenciesFiltered = self.listCurrency?.currenciesLoad?.filter({ (currencie) -> Bool in
			if searchText.count > 3 {
				let tmp: NSString = currencie.name as NSString
				let range = tmp.range(of: searchText, options: .caseInsensitive)
				return range.location != NSNotFound
			} else {
				let tmp: NSString = currencie.code as NSString
				let range = tmp.range(of: searchText, options: .caseInsensitive)
				return range.location != NSNotFound
			}
		}) ?? []
		
		if self.currenciesFiltered.count == 0 {
			self.searchBarActive = false
		} else {
			self.searchBarActive = true
		}
		
	}
	
	func didSelectedCurrency(indexPath: IndexPath) {
		if self.searchBarActive {
			self.delegate?.didSelectecCurrency(value: self.currenciesFiltered[indexPath.row])
		} else {
			self.delegate?.didSelectecCurrency(value: self.listCurrency?.currenciesLoad?[indexPath.row])
		}
	}
		
}
