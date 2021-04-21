//
//  ListagemMoedasVM.swift
//  Conversor Moedas
//
//  Created by Alexandre Cardoso on 21/04/21.
//

import Foundation

class ListagemMoedasVM {
	
	// MARK: - Variable
	private let listMoedaWorker: ListagemMoedasWorker = ListagemMoedasWorker()
	private var listCurrency: ListCurrency?
	private var currencies: [Currency] = [Currency]()
	private var currenciesFiltered: [Currency] = [Currency]()
	
	var searchBarActive: Bool = false
	
	
	// MARK: - Function
	func loadListCurrency(completion: @escaping(_ success: Bool) -> Void) {
		listMoedaWorker.loadListCurrency { (currency, error) in
			if let _currency = currency {
				self.listCurrency = _currency
				
				for (key, value) in _currency.currencies {
					self.currencies.append(Currency(code: key, name: value))
				}
				
				completion(true)
			} else {
				completion(false)
			}
		}
	}
	
	func numberOfRows() -> Int {
		if self.searchBarActive {
			return self.currenciesFiltered.count
		} else {
			return self.currencies.count
		}
	}
	
	func getCurrency(indexPath: IndexPath) -> Currency {
		if self.searchBarActive {
			return self.currenciesFiltered[indexPath.row]
		} else {
			return self.currencies[indexPath.row]
		}
	}
	
	func isActiveSearchBar(value: Bool) {
		self.searchBarActive = value
	}
	
	func searchBar(textDidChange searchText: String) {
		self.currenciesFiltered = self.currencies.filter({ (currencie) -> Bool in
			let tmp: NSString = currencie.code as NSString
			let range = tmp.range(of: searchText, options: .caseInsensitive)
			return range.location != NSNotFound
		})
		
		if self.currenciesFiltered.count == 0 {
			self.searchBarActive = false
		} else {
			self.searchBarActive = true
		}
		
	}
		
}
