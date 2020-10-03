//
//  DataParser.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil on 02/10/2020.
//  Copyright © 2020 Kamil Gacek. All rights reserved.
//

import Foundation

class DataFetcher {
    
    static let shared = DataFetcher()
    private init() {}

    private let mainUrl = Environment.serverURL.absoluteString

    func fetchCharacters(completion: @escaping ([Character]?, Error?) -> Void) {
        let url = mainUrl + "/api/v1/Articles/Top?expand=1&category=Articles&limit=65"
        
        getFetcher(urlString: url) { completion($0, $1) }
    }

    private func getFetcher(urlString: String, completion: @escaping ([Character]?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, FetcherError.wrongURL)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, FetcherError.wrongData)
                return
            }

            do {
                let model = try JSONDecoder().decode(FandomData.self, from: data)
                
                completion(model.items, nil)
            } catch let err {
                completion(nil, err)
            }
        }.resume()
    }
}

enum FetcherError: Error {
    case wrongURL
    case wrongData
}
