//
//  PokemonTeamRepository.swift
//
//
//  Created by Scizor on 5/3/24.
//

import CoreData

public protocol PokemonTeamRepository: PokemonStoreRetrieve, PokemonStoreDelete, PokemonStoreInsert {}

public protocol PokemonStoreRetrieve {
    func retrieve() async throws -> [PokemonModel]
}

public protocol PokemonStoreDelete {
    func delete(id: Int) async throws
}

public protocol PokemonStoreInsert {
    func insert(pokemon: PokemonModel) async throws
}

public enum StoreErrors: Error {
    case pokemonAlreadyAdded
}

public final class PokemonTeamRepositoryImplementation: PokemonTeamRepository {
    private let coreDataStore: PokemonTeamRepository
    
    public init(
        coreDataStore: PokemonTeamRepository = CoreDataPokemonStore(
            container: NSPersistentContainer.init(name: .containerName,
                                                  managedObjectModel: CoreDataPokemonStoreHelper.getManagedObject(containerName: .containerName)
                                                 )
        )
    ) {
        self.coreDataStore = coreDataStore
    }
    
    public func retrieve() async throws -> [PokemonModel] {
        return try await coreDataStore.retrieve()
    }
    
    public func insert(pokemon: PokemonModel) async throws {
        let pokemons = try await retrieve()
        guard pokemons.count < 6, pokemons.filter({ $0.id == pokemon.id }).isEmpty else {
            throw StoreErrors.pokemonAlreadyAdded
        }
        try await coreDataStore.insert(pokemon: pokemon)
    }
    
    public func delete(id: Int) async throws {
        try await coreDataStore.delete(id: id)
    }
}

public extension String {
    static var containerName: String {
        return "Pokemon"
    }
}
