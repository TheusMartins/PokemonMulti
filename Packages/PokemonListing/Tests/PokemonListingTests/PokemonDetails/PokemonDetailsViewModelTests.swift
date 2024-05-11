//
//  PokemonDetailsViewModelTests.swift
//
//
//  Created by Scizor on 5/9/24.
//

import XCTest
@testable import PokemonListing

final class PokemonDetailsViewModelTests: XCTestCase {
    var viewModel: PokemonDetailsViewModel!
    var repositorySpy: PokemonDetailRepositorySpy!
    var storeSpy: PokemonStoreInsertSpy!
    var delegateSpy: PokemonDetailsViewModelDelegateSpy!
    let testPokemonName = "Pikachu"
    
    override func setUp() {
        super.setUp()
        repositorySpy = PokemonDetailRepositorySpy()
        storeSpy = PokemonStoreInsertSpy()
        delegateSpy = PokemonDetailsViewModelDelegateSpy()
        viewModel = PokemonDetailsViewModel(repository: repositorySpy, store: storeSpy, pokemonName: testPokemonName)
        viewModel.delegate = delegateSpy
    }
    
    override func tearDown() {
        viewModel = nil
        repositorySpy = nil
        storeSpy = nil
        delegateSpy = nil
        super.tearDown()
    }
    
    func testGetPokemonSuccess() async {
        // Given
        let expectedPokemon = PokemonDetailsModel(id: 1, name: testPokemonName, sprites: PokemonSprites(front: URL(string: "https://example.com")), types: [])
        repositorySpy.nextPokemonDetailsModel = expectedPokemon
        
        // When
        await viewModel.getPokemon()
        
        // Then
        XCTAssertEqual(repositorySpy.getPokemonCallCount, 1)
        XCTAssertEqual(delegateSpy.didChangeStateCallCount, 1)
        if case let .didLoadDetails(pokemonDetail) = delegateSpy.lastState {
            XCTAssertEqual(pokemonDetail.name, expectedPokemon.name)
        } else {
            XCTFail("Expected .didLoadDetails state")
        }
    }
    
    func testGetPokemonFailure() async {
        // Given
        repositorySpy.shouldThrowError = true
        
        // When
        await viewModel.getPokemon()
        
        // Then
        XCTAssertEqual(repositorySpy.getPokemonCallCount, 1)
        XCTAssertEqual(delegateSpy.didChangeStateCallCount, 0, "Delegate should not be notified on failure")
    }
    
    func testAddPokemonSuccess() async {
        // Given
        let pokemonDetails = PokemonDetailsModel(id: 1, name: testPokemonName, sprites: PokemonSprites(front: URL(string: "https://example.com")!), types: [])
        repositorySpy.nextPokemonDetailsModel = pokemonDetails
        
        // Simulate getting pokemon details successfully
        await viewModel.getPokemon()
        
        // When
        await viewModel.addPokemon(imageData: Data())
        
        // Then
        XCTAssertEqual(storeSpy.insertCallCount, 1)
        XCTAssertEqual(delegateSpy.didChangeStateCallCount, 2) // One for loading details, one for adding
        if case let .addedPokemon(feedbackMessage) = delegateSpy.lastState {
            XCTAssertNotNil(feedbackMessage)
        } else {
            XCTFail("Expected .addedPokemon state")
        }
    }
    
    func testAddPokemonFailure() async {
        // Given
        let pokemonDetails = PokemonDetailsModel(id: 1, name: testPokemonName, sprites: PokemonSprites(front: URL(string: "https://example.com")!), types: [])
        repositorySpy.nextPokemonDetailsModel = pokemonDetails
        storeSpy.shouldThrowError = true
        
        // Simulate getting pokemon details successfully
        await viewModel.getPokemon()
        
        // When
        await viewModel.addPokemon(imageData: Data())
        
        // Then
        XCTAssertEqual(storeSpy.insertCallCount, 1)
        XCTAssertEqual(delegateSpy.didChangeStateCallCount, 2) // One for loading details, one for error on adding
        if case let .errorOnAddPokemon(feedbackMessage) = delegateSpy.lastState {
            XCTAssertNotNil(feedbackMessage)
        } else {
            XCTFail("Expected .errorOnAddPokemon state")
        }
    }
}
