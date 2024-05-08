//
//  PokemonListModel.swift
//
//
//  Created by Scizor on 5/8/24.
//

import Foundation

struct PokemonListModel: Codable {
    let results: [PokemonModel]
}

struct PokemonModel: Codable {
    let name: String
    let url: URL
}
