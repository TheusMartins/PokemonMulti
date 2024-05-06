//
//  PokemonTeamRepository.swift
//
//
//  Created by Scizor on 5/3/24.
//

import Foundation

protocol PokemonTeamRepository {
    func retrieve(completion: @escaping (Result<[PokemonModel], Error>) -> Void)
    func insert(pokemon: PokemonModel, completion: @escaping (Result<Never, Error>) -> Void)
    func delete(id: Int, completion: @escaping (Result<Never, Error>) -> Void)
}
