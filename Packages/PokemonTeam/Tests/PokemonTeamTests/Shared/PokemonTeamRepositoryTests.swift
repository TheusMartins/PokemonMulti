//
//  PokemonTeamRepositoryTests.swift
//
//
//  Created by Scizor on 5/7/24.
//

import XCTest
@testable import PokemonTeam

final class PokemonTeamRepositoryTests: XCTestCase {
    var spyStore: PokemonTeamRepositorySpy!
    var repository: PokemonTeamRepositoryImplementation!
    
    override func setUp() {
        super.setUp()
        spyStore = PokemonTeamRepositorySpy()
        repository = PokemonTeamRepositoryImplementation(coreDataStore: spyStore)
    }
    
    override func tearDown() {
        spyStore = nil
        repository = nil
        super.tearDown()
    }
    
    func test_retrieve_success() async throws {
        // Given
        let expectedPokemons = [PokemonTeam.PokemonModel(front: "frontData".data(using: .utf8), id: 6, name: "Charizard", types: ["Fire", "Flying"])]
        spyStore.insertedPokemons = expectedPokemons
        
        // When
        let pokemons = try await repository.retrieve()
        
        // Then
        XCTAssertEqual(pokemons, expectedPokemons)
    }
    
    func test_insert_success() async throws {
        // Given
        let newPokemon = PokemonTeam.PokemonModel(front: "frontData".data(using: .utf8), id: 6, name: "Charizard", types: ["Fire", "Flying"])
        
        // When
        try await repository.insert(pokemon: newPokemon)
        
        // Then
        XCTAssertEqual(spyStore.insertedPokemons.count, 1)
        XCTAssertTrue(spyStore.insertedPokemons.contains { $0.id == newPokemon.id && $0.name == newPokemon.name })
    }
    
    func test_delete_success() async throws {
        // Given
        let pokemonToDelete = PokemonTeam.PokemonModel(front: "frontData".data(using: .utf8), id: 6, name: "Charizard", types: ["Fire", "Flying"])
        spyStore.insertedPokemons = [pokemonToDelete]
        
        // When
        try await repository.delete(id: pokemonToDelete.id)
        
        // Then
        XCTAssertTrue(spyStore.insertedPokemons.isEmpty)
    }
    
    func test_insert_FailureWhenOverLimit() async throws {
        // Given
        spyStore.insertedPokemons = (1...6).map { PokemonTeam.PokemonModel(front: "frontData".data(using: .utf8), id: $0, name: "\($0)", types: ["Fire", "Flying"]) }
        let newPokemon = PokemonTeam.PokemonModel(front: "frontData".data(using: .utf8), id: 7, name: "Pikachu", types: ["Eletric"])
        
        do {
            try await repository.insert(pokemon: newPokemon)
            XCTFail("Insertion should not happen")
        } catch {
            XCTAssertEqual((error as? StoreErrors), StoreErrors.pokemonAlreadyAdded)
            XCTAssertEqual(spyStore.insertedPokemons.count, 6) // No new insertion should happen
        }
    }
}
