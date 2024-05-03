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
        self.container = NSPersistentContainer(name: "Pokemon")
        self.context = container.newBackgroundContext()
    }
    
    
    func retrieve(completion: @escaping (Result<PokemonModel, Error>) -> Void) {
        
    }
    
    func insert(pokemon: PokemonModel, completion: @escaping (Result<Never, Error>) -> Void) {
        
    }
    
    func delete(id: Int, completion: @escaping (Result<Never, Error>) -> Void) {
        
    }
}
