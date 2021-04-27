//
//  ListCurrency.swift
//  Conversor Moedas
//
//  Created by Alexandre Cardoso on 21/04/21.
//

import Foundation

/*
	Estrutura da API para Listagem de Moedas
{
	 "success": true,
	 "terms": "https://currencylayer.com/terms",
	 "privacy": "https://currencylayer.com/privacy",
	 "currencies": {
		  "AED": "United Arab Emirates Dirham",
		  "AFN": "Afghan Afghani",
		  "ALL": "Albanian Lek",
		  "AMD": "Armenian Dram",
		  "ANG": "Netherlands Antillean Guilder",
		  [...]
	 }
}
*/

struct ListCurrency: Decodable {
	let success: Bool
	let terms: String
	let privacy: String
	let currencies: [String: String]
	var currenciesLoad: [Currency]? = []
	
	mutating func loadCurrenciesSorted() {
		var temp: [Currency] = []
		
		for (key, value) in currencies {
			temp.append(Currency(code: key, name: value))
		}
		self.currenciesLoad = temp.sorted(by: {$0.code < $1.code})
	}
	
}

struct Currency: Decodable {
	let code: String
	let name: String
}
