//
//  PokemonDetailRepositorySpy.swift
//
//
//  Created by Scizor on 5/9/24.
//

@testable import PokemonListing
import CoordinatorÔ

final class PokemonDetailRepositorySpy: PokemonDetailRepository {
    // Properties to keep track of method calls and parameters
    private(set) var getPokemonCallCount = 0
    private(set) var lastPokemonName: String?
    
    // Properties to control the spy behavior
    var nextPokemonDetailsModel: PokemonDetailsModel?
    var nextError: Error?
    var shouldThrowError = false // Variable to decide if an error should be thrown
    
    // Custom error for demonstration
    enum SpyError: Error {
        case testError
    }
    
    // Implementation of the protocol method
    func getPokemon(pokemonName: String) async throws -> PokemonDetailsModel {
        getPokemonCallCount += 1
        lastPokemonName = pokemonName
        
        if shouldThrowError {
            throw nextError ?? SpyError.testError // Throw the predefined error or a default one
        }
        let spy = RouterNavigatorSpy()
        
        guard let nextPokemonDetailsModel = nextPokemonDetailsModel else {
            fatalError("nextPokemonDetailsModel was not set before use")
        }
        
        return nextPokemonDetailsModel
    }
}
