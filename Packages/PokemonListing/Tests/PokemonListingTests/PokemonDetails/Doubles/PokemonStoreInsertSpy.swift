//
//  PokemonStoreInsertSpy.swift
//
//
//  Created by Scizor on 5/9/24.
//

import PokemonTeam
import Foundation

final class PokemonStoreInsertSpy: PokemonStoreInsert {
    private(set) var insertCallCount = 0
    private(set) var lastInsertedPokemon: PokemonModel?
    
    var shouldThrowError = false
    var nextError: Error?
    
    private let standardError = NSError(domain: "com.PokemonStoreInsertSpy", code: -1, userInfo: [NSLocalizedDescriptionKey: "An error occurred during insertion"])
    
    func insert(pokemon: PokemonModel) async throws {
        insertCallCount += 1
        lastInsertedPokemon = pokemon
        
        if shouldThrowError {
            throw nextError ?? standardError
        }
    }
}
