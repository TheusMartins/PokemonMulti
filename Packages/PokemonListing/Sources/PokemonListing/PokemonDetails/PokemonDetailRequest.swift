//
//  PokemonDetailRequest.swift
//
//
//  Created by Scizor on 5/8/24.
//

import Network

enum PokemonDetailRequest {
    case getPokemonDetails(pokemonName: String)
}

extension PokemonDetailRequest: RequestInfos {
    var endpoint: String {
        switch self {
        case .getPokemonDetails(let pokemonName): return pokemonName
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        nil
    }
}
