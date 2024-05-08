//
//  TeamMemberViewModelDelegateSpy.swift
//
//
//  Created by Scizor on 5/7/24.
//

@testable import PokemonTeam

final class TeamMemberViewModelDelegateSpy: TeamMemberViewModelDelegate {
    var stateDidChangeCalled = false
    var lastState: TeamMemberViewModel.State?
    
    func stateDidChange(state: TeamMemberViewModel.State) {
        stateDidChangeCalled = true
        lastState = state
    }
}

