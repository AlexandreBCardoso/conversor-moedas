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
		return self.currencies.count
	}
	
	func getCurrency(indexPath: IndexPath) -> Currency {
		return self.currencies[indexPath.row]
	}
	
}
