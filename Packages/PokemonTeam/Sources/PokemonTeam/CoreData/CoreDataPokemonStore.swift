//
//  CoreDataPokemonStore.swift
//
//
//  Created by Scizor on 5/3/24.
//

import CoreData

final class CoreDataPokemonStore: PokemonTeamRepository {
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    init(container: NSPersistentContainer) {
        self.container = container
        self.context = container.newBackgroundContext()
    }
    
    // Retrieve function refactored to use async/await
    func retrieve() async throws -> [PokemonModel] {
        let fetchRequest = PokemonDataBase.fetchRequest()
        let cache = try await context.perform {
            try self.context.fetch(fetchRequest)
        }
        return cache.map { PokemonModel(front: $0.front, id: Int($0.id), name: $0.name, types: $0.types) }
    }
    
    // Insert function refactored to use async/await
    func insert(pokemon: PokemonModel) async throws {
        try await context.perform {
            let coreDataPokemon = PokemonDataBase(context: self.context)
            coreDataPokemon.id = Int16(pokemon.id)
            coreDataPokemon.name = pokemon.name
            coreDataPokemon.types = pokemon.types
            coreDataPokemon.front = pokemon.front
            
            try self.context.save()
        }
    }
    
    // Delete function refactored to use async/await
    func delete(id: Int) async throws {
        try await context.perform {
            let fetchRequest: NSFetchRequest<PokemonDataBase> = PokemonDataBase.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", id)
            
            let results = try self.context.fetch(fetchRequest)
            guard let pokemonToBeDeleted = results.first else { return }
            
            self.context.delete(pokemonToBeDeleted)
            try self.context.save()
        }
    }
    
    // Helper method to perform actions on the context
    private func perform(_ action: @escaping (NSManagedObjectContext) throws -> Void) async throws {
        try await withCheckedThrowingContinuation { continuation in
            context.perform {
                do {
                    try action(self.context)
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
