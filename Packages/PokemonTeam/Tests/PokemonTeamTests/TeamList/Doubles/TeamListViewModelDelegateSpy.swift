//
//  TeamListViewModelDelegateSpy.swift
//  
//
//  Created by Scizor on 5/7/24.
//

@testable import PokemonTeam

class TeamListViewModelDelegateSpy: TeamListViewModelDelegate {
    var stateDidChangeCalled = false
    var lastState: TeamListViewModel.State?
    
    func stateDidChange(state: TeamListViewModel.State) {
        stateDidChangeCalled = true
        lastState = state
    }
}
