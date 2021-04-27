//
//  ConversorWorker.swift
//  Conversor Moedas
//
//  Created by Alexandre Cardoso on 22/04/21.
//

import Foundation

class ConversorWorker {
	
	private let baseURL: String = "http://api.currencylayer.com/live?access_key=060020b8d4decd2ab29ef354b116928c"
	
	
	// MARK: - Function
	func loadListQuotes(completion: @escaping(_ success: ListCurrencyExchange?, _ error: Error?) -> Void) {
		
		guard let url = URL(string: baseURL) else {
			return completion(nil, nil)
		}
		
		URLSession.shared.dataTask(with: url) { (data, _, error) in
			guard let _data = data, error == nil else {
				return completion(nil, error)
			}
			
			let jsonDecoder = JSONDecoder()
			
			do {
				let list = try jsonDecoder.decode(ListCurrencyExchange.self, from: _data)
				completion(list, nil)
				
			} catch {
				print("==> Erro no JSON Taxa Quotes")
				print(error.localizedDescription)
				completion(nil, error)
			}
			
		}.resume()
		
	}
	
}
