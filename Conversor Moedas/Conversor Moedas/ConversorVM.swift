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
			}
			
		}
	}
	
	private func calculateExchange(value: String, origin: String, destiny: String) {
		let _value: Double = Double(value) ?? 0.0
		
		
		
		self.delegate?.successCalculatingExchangeValue(value: "\(destiny): ")
	}
	
	
}
