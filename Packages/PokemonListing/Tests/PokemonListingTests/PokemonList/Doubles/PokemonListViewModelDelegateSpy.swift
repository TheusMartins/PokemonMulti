//
//  PokemonListViewModelDelegateSpy.swift
//
//
//  Created by Scizor on 5/9/24.
//

import XCTest
@testable import PokemonListing

class PokemonListViewModelDelegateSpy: PokemonListViewModelDelegate {
    var recordedStates = [PokemonListViewModel.State]()
    
    // Implementation of the delegate method
    func stateDidChange(state: PokemonListViewModel.State) {
        recordedStates.append(state)
    }
}
