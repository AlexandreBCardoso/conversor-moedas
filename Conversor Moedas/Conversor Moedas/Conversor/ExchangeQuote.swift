//
//  ExchangeQuote.swift
//  Conversor Moedas
//
//  Created by Alexandre Cardoso on 26/04/21.
//

import Foundation

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
}

struct QuotesExchange: Decodable {
	let code: String
	let value: Double
}
