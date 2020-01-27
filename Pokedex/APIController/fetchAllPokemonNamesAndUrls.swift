//
//  fetchAllPokemonNamesAndUrls.swift
//  Pokedex
//
//  Created by alfredo on 1/26/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation

extension APIController{
    func fetchAllPokemonNamesAndUrls(completion: @escaping (Result<APIPokedexRequestContainer, NetworkError>) -> Void) {
        
        //MARK: - Get URL Request Ready
        
        let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=1000")!
        var request = URLRequest(url: baseUrl)

        request.httpMethod = HTTPMethod.get.rawValue

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                print("401")
                completion(.failure(.badAuth))
                return
            }

            guard error == nil else {
                print("other error")
                completion(.failure(.otherError))
                return
            }

            guard let data = data else {
                print("no data")
                completion(.failure(.badData))
                return
            }
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(APIPokedexRequestContainer.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
