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


/*
	Estrutura da API Taxa
{
  "success": true,
  "terms": "https://currencylayer.com/terms",
  "privacy": "https://currencylayer.com/privacy",
  "timestamp": 1619057584,
  "source": "USD",
  "quotes": {
	 "USDAED": 3.673204,
	 "USDAFN": 77.549938,
*/

struct ListCurrencyExchange: Decodable {
	let success: Bool
	let terms: String
	let privacy: String
	let timestamp: Int
	let source: String
	let quotes: [String: Double]
	var quotesLoad: [QuotesExchange]? = []

	mutating func loadQuotes() {
		var temp: [QuotesExchange] = []

		for (key, value) in quotes {
			temp.append(QuotesExchange(code: key, value: value))
		}
		self.quotesLoad = temp
	}
	
}

struct QuotesExchange: Decodable {
	let code: String
	let value: Double
}
