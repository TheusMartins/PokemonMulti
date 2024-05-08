//
//  PokemonRequest.swift
//
//
//  Created by Scizor on 5/8/24.
//

import Network

enum PokemonRequest {
    case getPokemons(generationId: Int)
}

extension PokemonRequest: RequestInfos {
    var endpoint: String {
        switch self {
        case .getPokemons(let generationId):
            return "\(String.endpoint)\(generationId)"
        }
    }
    
    var method: Network.HTTPMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        nil
    }
}

private extension String {
    static var endpoint: String {
        "generation/"
    }
}

