//
//  PokemonListController.swift
//
//
//  Created by Scizor on 5/8/24.
//

#if canImport(UIKit)
import UIKit

public final class PokemonListController: UIViewController {
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
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overrides
    public override func loadView() {
        self.view = customView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        loadPokemons()
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
            Task { @MainActor in
                await viewModel.changeGeneration(generation: generationIndex + 1)
            }
            
        case .didSelectPokemon(let pokemonName):
            let controller = PokemonDetailsController(pokemonName: pokemonName)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension PokemonListController: PokemonListViewModelDelegate {
    func stateDidChange(state: PokemonListViewModel.State) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            customView.setLoading(isLoading: false)
            switch state {
            case .didLoad(let generationModel, let pokemonModel):
                customView.viewModel = .init(generations: generationModel.map { $0.name }, pokemons: pokemonModel)
            case .didLoadNewGeneration(let pokemonModel):
                customView.viewModel.pokemons = pokemonModel
            case .didFailOnLoad(let feedbackMessage):
                showErrorModal(errorMessage: feedbackMessage)
            }
        }
    }
}

#endif
