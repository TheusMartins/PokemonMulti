//
//  PokemonDetailsViewModelDelegateSpy.swift
//
//
//  Created by Scizor on 5/9/24.
//

@testable import PokemonListing

final class PokemonDetailsViewModelDelegateSpy: PokemonDetailsViewModelDelegate {
    // Properties to keep track of the calls and passed data
    private(set) var didChangeStateCallCount = 0
    private(set) var lastState: PokemonDetailsViewModel.State?
    
    func didChange(state: PokemonDetailsViewModel.State) {
        didChangeStateCallCount += 1
        lastState = state
    }
}
