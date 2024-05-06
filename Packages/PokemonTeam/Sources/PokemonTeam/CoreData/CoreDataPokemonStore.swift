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
    
    init(container: NSPersistentContainer, context: NSManagedObjectContext) throws {
        self.container = container
        self.context = container.newBackgroundContext()
    }
    
    
    func retrieve(completion: @escaping (Result<[PokemonModel], Error>) -> Void) {
        let container = self.container
        perform { context in
            do {
                let cache = try container.viewContext.fetch(PokemonDataBase.fetchRequest())
                completion(.success(cache.map({ PokemonModel.init(front: $0.front, id: Int($0.id), name: $0.name, types: $0.types)})))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func insert(pokemon: PokemonModel, completion: @escaping (Result<Never, Error>) -> Void) {
        perform { context in
            do {
                let coreDataPokemon = PokemonDataBase(context: context)
                var type: [String] = []
                
                pokemon.types?.forEach { pokemonType in
                    type.append(pokemonType)
                }
                
                coreDataPokemon.id = Int16(pokemon.id)
                coreDataPokemon.name = pokemon.name
                coreDataPokemon.types = type
                coreDataPokemon.front = pokemon.front
                
                try context.save()
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func delete(id: Int, completion: @escaping (Result<Never, Error>) -> Void) {
        let container = self.container
        perform { context in
            do {
                let coreDataPokemon = try container.viewContext.fetch(PokemonDataBase.fetchRequest())
                guard let pokemonToBeDeleted = coreDataPokemon.first(where: { $0.id == id }) else { return }
                context.delete(pokemonToBeDeleted)
                try context.save()
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }
}
