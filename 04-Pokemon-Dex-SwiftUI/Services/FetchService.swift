//
//  FetchService.swift
//  04-Pokemon-Dex-SwiftUI
//
//  Created by sorlenko on 07/08/2026.
//

import Foundation

struct FetchService {
    enum FetchError: Error {
        case badRespond
    }
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func fetchPokemon(_ id: Int) async throws -> FetchedPokemonModel {
        
        let fetchUrl = baseUrl.appending(path: String(id))
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badRespond
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let pokemon = try decoder.decode(FetchedPokemonModel.self, from: data)
        
        print("Fetched: \(pokemon.id): \(pokemon.name.capitalized)")
        return pokemon
    }
}
