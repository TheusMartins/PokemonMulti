//
//  TeamListViewModelTests.swift
//
//
//  Created by Scizor on 5/7/24.
//

import XCTest
@testable import PokemonTeam

class TeamListViewModelTests: XCTestCase {
    var viewModel: TeamListViewModel!
    var delegateSpy: TeamListViewModelDelegateSpy!
    var spy: PokemonTeamRepositorySpy!
    
    override func setUp() {
        super.setUp()
        delegateSpy = TeamListViewModelDelegateSpy()
        spy = PokemonTeamRepositorySpy()
        viewModel = TeamListViewModel(store: spy)
        viewModel.delegate = delegateSpy
    }
    
    func testGetAllLocalPokemonsSuccess() async {
        // Given
        spy.insertedPokemons = [PokemonTeam.PokemonModel(front: "frontData".data(using: .utf8), id: 6, name: "Charizard", types: ["Fire", "Flying"])]
        
        // When
        await viewModel.getAllLocalPokemons()
        
        // Then
        XCTAssertTrue(delegateSpy.stateDidChangeCalled)
        if case .didLoadPokemons(let pokemons) = delegateSpy.lastState {
            XCTAssertEqual(pokemons.count, 1)
        } else {
            XCTFail("Expected .didLoadPokemons state")
        }
    }
    
    func testGetAllLocalPokemonsFailure() async {
        // Given
        spy.shouldReturnError = true
        
        // When
        await viewModel.getAllLocalPokemons()
        
        // Then
        XCTAssertTrue(delegateSpy.stateDidChangeCalled)
        if case .couldNotLoadPokemons(let errorMessage) = delegateSpy.lastState {
            XCTAssertEqual(errorMessage, "We could not load your team =(")
        } else {
            XCTFail("Expected .couldNotLoadPokemons state")
        }
    }
}
