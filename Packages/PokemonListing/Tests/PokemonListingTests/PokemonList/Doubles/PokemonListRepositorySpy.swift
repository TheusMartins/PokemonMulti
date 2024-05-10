//
//  File.swift
//  
//
//  Created by Scizor on 5/9/24.
//

import XCTest
@testable import PokemonListing

// Error type for simulating failures in tests
enum PokemonRepositoryError: Error {
    case simulatedError
}

final class PokemonListRepositorySpy: PokemonListRepository {
    // Properties to keep track of method calls
    var getGenerationsCalled = false
    var getPokemonsCalled = false
    var getPokemonsReceivedGenerationId: Int?
    
    // Properties to configure spy behavior
    var stubbedGenerationsResult: PokemonListing.PokemonGenerationModel!
    var stubbedPokemonsResult: PokemonListing.PokemonListModel!
    var shouldThrowError = false
    
    func getGenerations() async throws -> PokemonListing.PokemonGenerationModel {
        getGenerationsCalled = true
        if shouldThrowError {
            throw PokemonRepositoryError.simulatedError
        }
        return stubbedGenerationsResult
    }
    
    func getPokemons(generationId: Int) async throws -> PokemonListing.PokemonListModel {
        getPokemonsCalled = true
        getPokemonsReceivedGenerationId = generationId
        if shouldThrowError {
            throw PokemonRepositoryError.simulatedError
        }
        return stubbedPokemonsResult
    }
    
    // Helper methods for test assertions
    func verifyGetGenerationsCalled() -> Bool {
        return getGenerationsCalled
    }
    
    func verifyGetPokemonsCalled(with generationId: Int? = nil) -> Bool {
        return getPokemonsCalled && (generationId == nil || getPokemonsReceivedGenerationId == generationId)
    }
    
    // Method to reset spy state between tests
    func reset() {
        getGenerationsCalled = false
        getPokemonsCalled = false
        getPokemonsReceivedGenerationId = nil
        stubbedGenerationsResult = nil
        stubbedPokemonsResult = nil
        shouldThrowError = false
    }
}
