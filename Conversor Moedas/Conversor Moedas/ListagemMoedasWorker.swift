//
//  ListagemMoedasWorker.swift
//  Conversor Moedas
//
//  Created by Alexandre Cardoso on 21/04/21.
//

import Foundation

class ListagemMoedasWorker {
	
	private let baseURL: String = "http://api.currencylayer.com/list?access_key=060020b8d4decd2ab29ef354b116928c"
	
	
	// MARK: - Function
	func loadListCurrency(completion: @escaping(_ success: ListCurrency?, _ error: Error?) -> Void) {
		
		guard let url = URL(string: baseURL) else {
			return completion(nil, nil)
		}
		
		URLSession.shared.dataTask(with: url) { (data, _, error) in
			guard let _data = data, error == nil else {
				return completion(nil, error)
			}
			
			let jsonDecoder = JSONDecoder()
			
			do {
				let list = try jsonDecoder.decode(ListCurrency.self, from: _data)
				completion(list, nil)
				
			} catch {
				print("==> Erro no JSON Listagem de Moedas")
				print(error.localizedDescription)
				completion(nil, error)
			}
			
		}.resume()
		
	}
	
}
