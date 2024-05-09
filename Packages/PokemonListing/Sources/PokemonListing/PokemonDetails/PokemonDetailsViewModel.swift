//
//  PokemonDetailsViewModel.swift
//
//
//  Created by Scizor on 5/8/24.
//

import PokemonTeam
import Foundation

protocol PokemonDetailsViewModelDelegate: AnyObject {
    func didChange(state: PokemonDetailsViewModel.State)
}

final class PokemonDetailsViewModel {
    // MARK: - Open properties
    
    enum State {
        case didLoadDetails(pokemonDetail: PokemonDetailsModel)
        case errorOnLoadPokemon(feedbackMessage: String)
        case addedPokemon(feedbackMessage: String)
        case errorOnAddPokemon(feedbackMessage: String)
    }
    
    weak var delegate: PokemonDetailsViewModelDelegate?
    
    // MARK: - Private properties
    
    private let repository: PokemonDetailRepository
    private let store: PokemonStoreInsert
    private let pokemonName: String
    private var pokemonModel: PokemonDetailsModel? {
        didSet {
            guard let pokemonModel else { return }
            delegate?.didChange(state: .didLoadDetails(pokemonDetail: pokemonModel))
        }
    }
    
    // MARK: - Initialization
    
    init(
        repository: PokemonDetailRepository = PokemonDetailRepositoryImplementation(),
        store: PokemonStoreInsert = PokemonTeamRepositoryImplementation(),
        pokemonName: String
    ) {
        self.repository = repository
        self.store = store
        self.pokemonName = pokemonName
    }

    // MARK: - Open methods
    
    func getPokemon() async {
        do {
            let pokemon = try await repository.getPokemon(pokemonName: pokemonName)
            pokemonModel = pokemon
        } catch {
            
        }
    }
    
    func addPokemon() async {
        guard let pokemon = pokemonModel else { return }
        do {
            try await store.insert(pokemon: .init(front: Data(), id: pokemon.id, name: pokemon.name, types: pokemon.types.map { $0.type.name }))
            delegate?.didChange(state: .addedPokemon(feedbackMessage: "Pokemon successfully added"))
        } catch {
            delegate?.didChange(state: .errorOnAddPokemon(feedbackMessage: "Pokemon not added, your team is complete or you already have this pokemon in your team"))
        }
    }
}
