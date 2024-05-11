//
//  TeamListControllerTests.swift
//  
//
//  Created by Scizor on 5/9/24.
//

#if canImport(UIKit)
import XCTest
@testable import PokemonTeam

class TeamListControllerTests: XCTestCase {
    var viewModel: TeamListViewModel!
    var delegateSpy: TeamListViewModelDelegateSpy!
    var spy: PokemonTeamRepositorySpy!
    var sut: TeamListController!
    
    override func setUp() {
        super.setUp()
        delegateSpy = TeamListViewModelDelegateSpy()
        spy = PokemonTeamRepositorySpy()
        viewModel = TeamListViewModel(store: spy)
        viewModel.delegate = delegateSpy
        sut = TeamListController(viewModel: viewModel)
    }
    
    func test_getAllLocalPokemons_calledOnViewModel() async {

        // When: triggers the life cycle
        await sut.loadViewIfNeeded()
        
        await sut.viewDidLoad()
        
        XCTAssertTrue(spy.retrieveWasCalled, "getAllLocalPokemons() was not called on the ViewModel during the ViewController's viewDidLoad.")
    }
}
#endif
