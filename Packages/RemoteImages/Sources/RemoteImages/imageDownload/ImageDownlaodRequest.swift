//
//  ImageDownlaodRequest.swift
//
//
//  Created by Scizor on 5/10/24.
//

import Network
import Foundation

enum ImageDownlaodRequest {
    case getPokemonWithId(Int)
    case getPokemonWithURL(URL)
}

//MARK: - TargetType
extension ImageDownlaodRequest: RequestInfos {
    var endpoint: String {
        switch self {
        case .getPokemonWithId(let pokemonId): return "\(pokemonId).png"
        case .getPokemonWithURL(_): return ""
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    private var baseURL: URL {
        switch self {
        case .getPokemonWithId(_): return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/")!
        case .getPokemonWithURL(let url): return url
        }
    }
}
