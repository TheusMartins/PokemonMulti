//
//  TeamListViewModel.swift
//
//
//  Created by Scizor on 5/6/24.
//

protocol TeamListViewModelDelegate: AnyObject {
    func stateDidChange(state: TeamListViewModel.State)
}

final class TeamListViewModel {
    //MARK: - Open properties
    weak var delegate: TeamListViewModelDelegate?
    
    //MARK: - Private properties
    
    private let store: PokemonStoreGet
    
    enum State {
        case didLoadPokemons(pokemons: [PokemonModel])
        case couldNotLoadPokemons(errorMessage: String)
    }
    
    //MARK: - Initialization
    
    init(store: PokemonStoreGet = PokemonTeamRepositoryImplementation()) {
        self.store = store
    }
    
    //MARK: - Open methods
    func getAllLocalPokemons() async {
        do {
            let pokemons = try await store.retrieve()
            delegate?.stateDidChange(state: .didLoadPokemons(pokemons: pokemons))
        } catch {
            delegate?.stateDidChange(state: .couldNotLoadPokemons(errorMessage: "We could not load your team =("))
        }
    }
}
