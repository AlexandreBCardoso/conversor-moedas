//
//  ConversorVM.swift
//  Conversor Moedas
//
//  Created by Alexandre Cardoso on 22/04/21.
//

import Foundation

protocol ConversorVMProtocol: class {
	func successCalculatingExchangeValue(value: String)
}

class ConversorVM {
	
	// MARK: - Variable
	private var quotes: ListCurrencyExchange?
	weak var delegate: ConversorVMProtocol?
	
	
	// MARK: - Function
	func getQuotes(value: String, origin: String, destiny: String) {
		ConversorWorker().loadListQuotes { (quotes, error) in
			if let _quotes = quotes {
				self.quotes = _quotes
				self.calculateExchange(value: value, origin: origin, destiny: destiny)
			}
			
		}
	}
	
	private func calculateExchange(value: String, origin: String, destiny: String) {
		let quantity: Double = Double(value) ?? 0.0
		let currencyCodeOrigem: String = "USD" + origin
		let currencyCodeDestino: String = "USD" + destiny
		
		let currencyValueOrigem: Double = self.quotes?.quotes[currencyCodeOrigem] ?? 0.0
		let currencyValueDestino: Double = self.quotes?.quotes[currencyCodeDestino] ?? 0.0
		
		let valueDollar: Double = quantity / currencyValueOrigem
		let valueConvert: Double = currencyValueDestino * valueDollar
				
		self.delegate?.successCalculatingExchangeValue(value: String(format: "%.2f", valueConvert))
	}
	
	
}
