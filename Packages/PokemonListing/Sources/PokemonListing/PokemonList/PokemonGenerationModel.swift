//
//  PokemonGenerationModel.swift
//
//
//  Created by Scizor on 5/8/24.
//

import Foundation

struct PokemonGenerationModel: Codable {
    let results: [PokemonModel]
}

struct GenerationModel: Codable {
    let name: String
    let url: URL
}
