//
//  TeamMemberViewModelTests.swift
//
//
//  Created by Scizor on 5/7/24.
//

import XCTest
@testable import PokemonTeam

class TeamMemberViewModelTests: XCTestCase {
    var viewModel: TeamMemberViewModel!
    var delegateSpy: TeamMemberViewModelDelegateSpy!
    var spy: PokemonTeamRepositorySpy!
    var pokemon: PokemonTeam.PokemonModel!
    
    override func setUp() {
        super.setUp()
        delegateSpy = TeamMemberViewModelDelegateSpy()
        spy = PokemonTeamRepositorySpy()
        pokemon = PokemonTeam.PokemonModel(front: "frontData".data(using: .utf8), id: 6, name: "Charizard", types: ["Fire", "Flying"])
        viewModel = TeamMemberViewModel(store: spy, pokemon: pokemon)
        viewModel.delegate = delegateSpy
    }
    
    func test_removePokemonFromTeamSuccess() async {
        // When
        await viewModel.removePokemonFromTeam()
        
        // Then
        XCTAssertTrue(spy.deleteWasCalled)
        XCTAssertEqual(spy.deletedPokemonIds.first, pokemon.id)
        XCTAssertTrue(delegateSpy.stateDidChangeCalled)
        if case .didDeleteTeamMember(let feedbackMessage) = delegateSpy.lastState {
            XCTAssertEqual(feedbackMessage, "\(pokemon.name?.capitalized ?? "") has been removed from your team")
        } else {
            XCTFail("Expected .didDeleteTeamMember state")
        }
    }
    
    func test_removePokemonFromTeamFailure() async {
        // Given
        spy.shouldReturnError = true
        
        // When
        await viewModel.removePokemonFromTeam()
        
        // Then
        XCTAssertTrue(delegateSpy.stateDidChangeCalled)
        if case .couldNotDeleteTeamMember(let errorMessage) = delegateSpy.lastState {
            XCTAssertEqual(errorMessage, "Somenthing went wrong, we could not delete your pokemon team member")
        } else {
            XCTFail("Expected .couldNotDeleteTeamMember state")
        }
    }
    
    func test_loadPokemon() {
        // When
        viewModel.laodPokemon()
        
        // Then
        XCTAssertTrue(delegateSpy.stateDidChangeCalled)
        if case .didLoadTeamMember(let pokemons) = delegateSpy.lastState {
            XCTAssertEqual(pokemons.id, pokemon.id)
        } else {
            XCTFail("Expected .didLoadTeamMember state")
        }
    }
}
