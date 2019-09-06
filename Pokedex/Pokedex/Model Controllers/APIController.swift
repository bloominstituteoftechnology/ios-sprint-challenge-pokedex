//
//  APIController.swift
//  Pokedex
//
//  Created by Jordan Christensen on 9/6/19.
//  Copyright © 2019 Mazjap Co Technologies. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case encodingError
    case responseError
    case otherError(Error)
    case noData
    case badDecode
    case noToken // No bearer token
}

class APIController {
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    var pokemon: [Pokemon] = []
    
    func getPokemon(with searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let searchURL = baseURL
            .appendingPathComponent("pokemon")
            .appendingPathComponent(searchTerm)
        
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for pokemon on line \(#line) in \(#file): \(error)")
                completion(.failure(.otherError(error)))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from searching for pokemon")
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                var newPokemon = try decoder.decode(Pokemon.self, from: data)
                newPokemon.name = newPokemon.name.capitalized
                self.pokemon.append(newPokemon)
                self.pokemon.sort { $0.id < $1.id }
                completion(.success(newPokemon))
                return
            } catch {
                NSLog("Error decoding pokemon on line \(#line): \(error)")
                completion(.failure(.badDecode))
                return
            }
        }.resume()
    }
    
}
