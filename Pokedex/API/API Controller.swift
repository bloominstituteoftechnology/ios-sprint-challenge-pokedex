//
//  PokemonAPIController.swift
//  Pokedex
//
//  Created by Andrew Ruiz on 10/4/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkingError: Error {
    case serverError(Error)
    case unexpectedStatusCode
    case noData
    case badDecode
}

class APIController {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    
    func fetchPokemon(pokemonName: String, completion: @escaping (Result<Pokemon, NetworkingError>) -> Void) {
        
        // Setting up URL
        let requestURL = baseURL
            .appendingPathComponent("pokemon")
            .appendingPathComponent(pokemonName)
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Creating Data Task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error fetching pokemon names: \(error)")
                completion(.failure(.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failure(.unexpectedStatusCode))
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                NSLog("Error decoding animal names: \(error)")
                completion(.failure(.badDecode))
            }
        }.resume()
    }
}
