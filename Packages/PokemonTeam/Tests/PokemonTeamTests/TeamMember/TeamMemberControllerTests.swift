//
//  TeamMemberControllerTests.swift
//
//
//  Created by Scizor on 5/9/24.
//

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
    
}
