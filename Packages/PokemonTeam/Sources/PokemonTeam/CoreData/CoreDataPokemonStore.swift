//
//  CoreDataPokemonStore.swift
//
//
//  Created by Scizor on 5/3/24.
//

import CoreData

public final class CoreDataPokemonStore: PokemonTeamRepository {
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    public init(container: NSPersistentContainer) {
        self.container = container
        self.container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
        }
        self.context = container.newBackgroundContext()
    }
    
    public func retrieve() async throws -> [PokemonModel] {
        let fetchRequest = PokemonDataBase.fetchRequest()
        let context = self.context
        let cache = try await context.perform {
            try context.fetch(fetchRequest)
        }
        return cache.map { PokemonModel(front: $0.front, id: Int($0.id), name: $0.name, types: $0.types) }
    }
    
    public func insert(pokemon: PokemonModel) async throws {
        try await context.perform {
            let coreDataPokemon = PokemonDataBase(context: self.context)
            coreDataPokemon.id = Int16(pokemon.id)
            coreDataPokemon.name = pokemon.name
            coreDataPokemon.types = pokemon.types
            coreDataPokemon.front = pokemon.front
            
            try self.context.save()
        }
    }
    
    public func delete(id: Int) async throws {
        try await context.perform {
            let fetchRequest: NSFetchRequest<PokemonDataBase> = PokemonDataBase.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", id)
            
            let results = try self.context.fetch(fetchRequest)
            guard let pokemonToBeDeleted = results.first else { return }
            
            self.context.delete(pokemonToBeDeleted)
            try self.context.save()
        }
    }
    
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

public enum CoreDataPokemonStoreHelper {
    static public func getManagedObject(containerName: String) -> NSManagedObjectModel {
        guard let modelURL = Bundle.module.url(forResource: containerName, withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Could not load model")
        }
        return managedObjectModel
    }
}
