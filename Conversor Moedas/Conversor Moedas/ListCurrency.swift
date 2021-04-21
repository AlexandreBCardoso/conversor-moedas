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
}

struct Currency {
	let code: String
	let name: String
}
