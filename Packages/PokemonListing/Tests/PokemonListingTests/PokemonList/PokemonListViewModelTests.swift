//
//  PokemonListViewModelTests.swift
//
//
//  Created by Scizor on 5/9/24.
//

import XCTest
@testable import PokemonListing

final class PokemonListViewModelTests: XCTestCase {
    var viewModel: PokemonListViewModel!
    var repositorySpy: PokemonListRepositorySpy!
    var delegateSpy: PokemonListViewModelDelegateSpy!
    
    override func setUp() {
        super.setUp()
        repositorySpy = PokemonListRepositorySpy()
        delegateSpy = PokemonListViewModelDelegateSpy()
        viewModel = PokemonListViewModel(repository: repositorySpy)
        viewModel.delegate = delegateSpy
    }
    
    override func tearDown() {
        viewModel = nil
        repositorySpy = nil
        delegateSpy = nil
        super.tearDown()
    }
    
    func testGetPokemonsSuccess() async {
        // Given
        let expectedGenerations = PokemonGenerationModel(results: [GenerationModel]()) // Populate with test data
        let expectedPokemons = PokemonListModel(results: [PokemonModel]()) // Populate with test data
        repositorySpy.stubbedGenerationsResult = expectedGenerations
        repositorySpy.stubbedPokemonsResult = expectedPokemons
        
        // When
        await viewModel.getPokemons()
        
        // Then
        XCTAssertTrue(repositorySpy.getGenerationsCalled)
        XCTAssertTrue(delegateSpy.recordedStates.contains(where: { state in
            if case .didLoad(let generationModel, let pokemonModel) = state,
               generationModel.count == 0,
               pokemonModel.count == 0 {
                return true
            }
            return false
        }))
    }
    
    func testGetPokemonsFailure() async {
        // Given
        repositorySpy.shouldThrowError = true
        
        // When
        await viewModel.getPokemons()
        
        // Then
        XCTAssertTrue(repositorySpy.getGenerationsCalled)
        XCTAssertFalse(repositorySpy.getPokemonsCalled) // getPokemons should not be called if getGenerations fails
        XCTAssertTrue(delegateSpy.recordedStates.contains(where: { state in
            if case .didFailOnLoad(let feedbackMessage) = state,
               feedbackMessage == "We could not load pokemons, please try again" {
                return true
            }
            return false
        }))
    }
    
    func testChangeGenerationSuccess() async {
        // Given
        let newGenerationId = 2
        let expectedPokemons = PokemonListModel(results: [PokemonModel]()) // Populate with test data for the new generation
        repositorySpy.stubbedPokemonsResult = expectedPokemons
        
        // When
        await viewModel.changeGeneration(generation: newGenerationId)
        
        // Then
        XCTAssertTrue(delegateSpy.recordedStates.contains(where: { state in
            if case .didLoadNewGeneration(let pokemonModel) = state,
               pokemonModel.count == 0 {
                return true
            }
            return false
        }))
    }
    
    func testChangeGenerationFailure() async {
        // Given
        let newGenerationId = 2
        repositorySpy.shouldThrowError = true
        
        // When
        await viewModel.changeGeneration(generation: newGenerationId)
        
        // Then
        XCTAssertTrue(delegateSpy.recordedStates.contains(where: { state in
            if case .didFailOnLoad(let feedbackMessage) = state,
               feedbackMessage == "We could not load pokemons, please try again" {
                return true
            }
            return false
        }))
    }
}
