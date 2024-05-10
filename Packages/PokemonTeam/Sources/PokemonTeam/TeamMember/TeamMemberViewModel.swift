//
//  TeamMemberViewModel.swift
//  
//
//  Created by Scizor on 5/6/24.
//

protocol TeamMemberViewModelDelegate: AnyObject {
    func stateDidChange(state: TeamMemberViewModel.State)
}

final class TeamMemberViewModel {
    //MARK: - Open properties
    weak var delegate: TeamMemberViewModelDelegate?
    
    //MARK: - Private properties
    private let store: PokemonStoreDelete
    private let pokemon: PokemonModel
    
    enum State {
        case didLoadTeamMember(pokemons: PokemonModel)
        case didDeleteTeamMember(feedbackMessage: String)
        case couldNotDeleteTeamMember(errorMessage: String)
    }
    
    //MARK: - Initialization
    init(
        store: PokemonStoreDelete = PokemonTeamRepositoryImplementation(),
        pokemon: PokemonModel
    ) {
        self.store = store
        self.pokemon = pokemon
    }
    
    // MARK: - Public methods
    func removePokemonFromTeam() async {
        do {
            try await store.delete(id: pokemon.id)
            delegate?.stateDidChange(state: .didDeleteTeamMember(feedbackMessage: "\(pokemon.name?.capitalized ?? "") has been removed from your team"))
        } catch {
            delegate?.stateDidChange(state: .couldNotDeleteTeamMember(errorMessage: "Somenthing went wrong, we could not delete your pokemon team member"))
        }
    }
    
    func laodPokemon() {
        delegate?.stateDidChange(state: .didLoadTeamMember(pokemons: pokemon))
    }
}
