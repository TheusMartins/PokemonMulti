//
//  TeamMemberControllerTests.swift
//
//
//  Created by Scizor on 5/9/24.
//

#if canImport(UIKit)
import XCTest
@testable import PokemonTeam

class TeamMemberControllerTests: XCTestCase {
    var viewModel: TeamMemberViewModel!
    var delegateSpy: TeamMemberViewModelDelegateSpy!
    var spy: PokemonTeamRepositorySpy!
    var pokemon: PokemonTeam.PokemonModel!
    var sut: TeamMemberController!
    
    override func setUp() {
        super.setUp()
        delegateSpy = TeamMemberViewModelDelegateSpy()
        spy = PokemonTeamRepositorySpy()
        pokemon = PokemonTeam.PokemonModel(front: "frontData".data(using: .utf8), id: 6, name: "Charizard", types: ["Fire", "Flying"])
        viewModel = TeamMemberViewModel(store: spy, pokemon: pokemon)
        viewModel.delegate = delegateSpy
        sut = TeamMemberController(viewModel: viewModel)
    }
    
    func test_getAllLocalPokemons_calledOnViewModel() {
        // When
        sut.didTrigger(action: .didTapOnDelete)
        
        // XCTestExpectation can also be used here if the async/await pattern is not suitable
        let expectation = XCTestExpectation(description: "Deletion expectation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5) // I think its a incompatibility because without expectation the deleteWasCalled result is not mirroring what is happening
        
        // Then
        XCTAssertTrue(spy.deleteWasCalled, "didTrigger(action: .didTapOnDelete) was not called on the ViewModel when controller required.")
    }
}
#endif
