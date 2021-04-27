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
	func didSelectecCurrencyOrigin(value: Currency?)
	func didSelectecCurrencyDestiny(value: Currency?)
}

class ListagemMoedasVM {
	
	// MARK: - Variable
	private let listMoedaWorker: ListagemMoedasWorker = ListagemMoedasWorker()
	private var listCurrency: ListCurrency?
	private var currenciesFiltered: [Currency] = [Currency]()
	private var searchBarActive: Bool = false
	private var searchNotFound: Bool = false
	weak var delegate: ListagemMoedasVMDelegate?
	private var tag: Int?
	
	
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
		if self.searchNotFound {
			return 1
		}
		
		if self.searchBarActive {
			return self.currenciesFiltered.count
		} else {
			return self.listCurrency?.currenciesLoad?.count ?? 0
		}
	}
	
	func getCurrency(indexPath: IndexPath) -> Currency? {
		
		if self.searchNotFound {
			return Currency(code: "", name: "Não encontrado Moeda")
		}
		
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
			self.searchNotFound = true
		} else {
			self.searchBarActive = true
			self.searchNotFound = false
		}
		
	}
	
	func didSelectedCurrency(indexPath: IndexPath) {
		var currencySelected: Currency?
		
		if self.searchBarActive {
			currencySelected = self.currenciesFiltered[indexPath.row]
		} else {
			currencySelected = self.listCurrency?.currenciesLoad?[indexPath.row]
		}
		
		if self.tag == 1 {
			self.delegate?.didSelectecCurrencyOrigin(value: currencySelected)
		} else {
			self.delegate?.didSelectecCurrencyDestiny(value: currencySelected)
		}
		
	}
	
	func setTagButton(value: Int?) {
		self.tag = value
	}
		
}
