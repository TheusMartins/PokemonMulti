//
//  PokemonTeamRepositorySpy.swift
//
//
//  Created by Scizor on 5/7/24.
//

@testable import PokemonTeam

struct PokemonModel {
    var id: Int
    var name: String
}

enum PokemonStoreError: Error {
    case notFound
    case databaseError
}

final class PokemonTeamRepositorySpy: PokemonTeamRepository {
    var shouldReturnError = false
    var retrieveWasCalled = false
    var deleteWasCalled = false
    var insertWasCalled = false
    
    var insertedPokemons: [PokemonTeam.PokemonModel] = []
    var deletedPokemonIds: [Int] = []
    
    func retrieve() async throws -> [PokemonTeam.PokemonModel] {
        retrieveWasCalled = true
        if shouldReturnError {
            throw PokemonStoreError.databaseError
        } else {
            return insertedPokemons
        }
    }
    
    func delete(id: Int) async throws {
        deleteWasCalled = true
        if shouldReturnError {
            throw PokemonStoreError.notFound
        } else {
            deletedPokemonIds.append(id)
            insertedPokemons.removeAll { $0.id == id }
        }
    }
    
    func insert(pokemon: PokemonTeam.PokemonModel) async throws {
        insertWasCalled = true
        if shouldReturnError {
            throw PokemonStoreError.databaseError
        } else {
            insertedPokemons.append(pokemon)
        }
    }
}
