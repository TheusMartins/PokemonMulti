//
//  PokemonTeamRepository.swift
//
//
//  Created by Scizor on 5/3/24.
//

import CoreData

protocol PokemonTeamRepository: PokemonStoreRetrieve, PokemonStoreDelete, PokemonStoreInsert {}

protocol PokemonStoreRetrieve {
    func retrieve() async throws -> [PokemonModel]
}

protocol PokemonStoreDelete {
    func delete(id: Int) async throws
}

protocol PokemonStoreInsert {
    func insert(pokemon: PokemonModel) async throws
}

final class PokemonTeamRepositoryImplementation: PokemonTeamRepository {
    private let coreDataStore: CoreDataPokemonStore
    
    init(coreDataStore: CoreDataPokemonStore = .init(container: NSPersistentContainer.init(name: .containerName))) {
        self.coreDataStore = coreDataStore
    }
    
    func retrieve() async throws -> [PokemonModel] {
        return try await coreDataStore.retrieve()
    }
    
    func insert(pokemon: PokemonModel) async throws {
        let pokemons = try await retrieve()
        guard pokemons.count < 6, pokemons.filter({ $0.id == pokemon.id }).count > 0 else { return }
        try await coreDataStore.insert(pokemon: pokemon)
    }
    
    func delete(id: Int) async throws {
        try await coreDataStore.delete(id: id)
    }
}

private extension String {
    static var containerName: String {
        return "Pokemon"
    }
}
