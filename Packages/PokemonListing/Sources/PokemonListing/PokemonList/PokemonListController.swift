//
//  PokemonListController.swift
//
//
//  Created by Scizor on 5/8/24.
//

import UIKit

final class PokemonListController: UIViewController {
    // MARK: - Private properties
    private lazy var customView: PokemonListView = {
        let view = PokemonListView(viewModel: .init(generations: [], pokemons: []))
        view.delegate = self
        return view
    }()
    
    private lazy var viewModel: PokemonListViewModel = {
        let viewModel = PokemonListViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    //MARK: - Initialization
    init(viewmodel: PokemonListViewModel = PokemonListViewModel()) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overrides
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPokemons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Private methods
    private func loadPokemons(generationIndex: Int = 0) {
        customView.setLoading(isLoading: true)
        Task {
            await viewModel.getPokemons()
        }
    }
    
    private func showErrorModal(errorMessage: String) {
        let alert = UIAlertController(title: errorMessage, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Try again", style: .cancel) { [weak self] _ in
            guard let self else { return }
            self.loadPokemons()
        }
        alert.addAction(alertAction)
        navigationController?.present(alert, animated: true, completion: nil)
        
    }
}

extension PokemonListController: PokemonListViewDelegate {
    func didTriggerAction(action: PokemonListView.Actions) {
        switch action {
        case .didChangeGeneration(let generationIndex):
            Task {
                await viewModel.changeGeneration(generation: generationIndex + 1)
            }
            
        case .didSelectPokemon(let pokemonIndex):
            print(pokemonIndex)
        }
    }
}

extension PokemonListController: PokemonListViewModelDelegate {
    func stateDidChange(state: PokemonListViewModel.State) {
        customView.setLoading(isLoading: false)
        switch state {
        case .didLoad(let generationModel, let pokemonModel):
            customView.viewModel = .init(generations: generationModel.map { $0.name }, pokemons: pokemonModel.map { $0.name })
        case .didLoadNewGeneration(let pokemonModel):
            customView.viewModel.pokemons = pokemonModel.map { $0.name }
        case .didFailOnLoad(let feedbackMessage):
            showErrorModal(errorMessage: feedbackMessage)
        }
    }
}

