//
//  PokemonTeamRepository.swift
//
//
//  Created by Scizor on 5/3/24.
//

import Foundation

protocol PokemonTeamRepository {
    func retrieve() async throws -> [PokemonModel]
    func insert(pokemon: PokemonModel) async throws
    func delete(id: Int) async throws
}
