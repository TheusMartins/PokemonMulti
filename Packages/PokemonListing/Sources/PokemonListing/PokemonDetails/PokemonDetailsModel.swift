//
//  PokemonDetailsModel.swift
//
//
//  Created by Scizor on 5/8/24.
//

import Foundation

struct PokemonDetailsModel: Codable {
    let id: Int
    let name: String
    let sprites: PokemonSprites
    let types: [PokemonType]
}

struct PokemonSprites: Codable {
    let front: URL?
    
    enum CodingKeys: String, CodingKey {
        case front = "front_default"
    }
}

struct PokemonType: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}
