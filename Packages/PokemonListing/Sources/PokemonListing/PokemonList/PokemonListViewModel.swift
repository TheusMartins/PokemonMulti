//
//  PokemonListViewModel.swift
//
//
//  Created by Scizor on 5/8/24.
//

import Foundation

protocol PokemonListViewModelDelegate: AnyObject {
    func stateDidChange(state: PokemonListViewModel.State)
}

final class PokemonListViewModel {
    // MARK: - Private properties
    
    private let repository: PokemonListRepository
    private var selectedGeneration: Int = 1
    
    // MARK: - Open properties
    
    enum State {
        case didLoad(generationModel: [GenerationModel], pokemonModel: [PokemonModel])
        case didLoadNewGeneration(pokemonModel: [PokemonModel])
        case didFailOnLoad(feedbackMessage: String)
    }
    
    weak var delegate: PokemonListViewModelDelegate?
    
    // MARK: - Initialization
    
    init(repository: PokemonListRepository = PokemonListRepositoryImplementation()) {
        self.repository = repository
    }
    
    // MARK: - Open methods
    
    func getPokemons() async {
        do {
            let generationModel = try await repository.getGenerations()
            let pokemonModel = try await repository.getPokemons(generationId: selectedGeneration)
            delegate?.stateDidChange(state: .didLoad(generationModel: generationModel.results, pokemonModel: pokemonModel.results))
        } catch {
            delegate?.stateDidChange(state: .didFailOnLoad(feedbackMessage: "We could not load pokemons, please try again"))
        }
    }
    
    func changeGeneration(generation: Int) async {
        selectedGeneration = generation
        do {
            let pokemonModel = try await repository.getPokemons(generationId: selectedGeneration)
            delegate?.stateDidChange(state: .didLoadNewGeneration(pokemonModel: pokemonModel.results))
        } catch {
            delegate?.stateDidChange(state: .didFailOnLoad(feedbackMessage: "We could not load pokemons, please try again"))
        }
    }
}
