//
//  PokemonListController.swift
//
//
//  Created by Scizor on 5/8/24.
//

#if canImport(UIKit)
import UIKit
import Coordinator

public protocol PokemonListCoordinatorDelegate: AnyObject, AlertDelegate {
    func showPokemonDetails(pokemonName: String)
    func didCloseFlow()
}

public final class PokemonListController: UIViewController {
    // MARK: - Open properties
    
    var delegate: PokemonListCoordinatorDelegate?
    
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
    
    // MARK: - Initialization
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    
    public override func loadView() {
        self.view = customView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationBar()
        loadPokemons()
    }
    
    // MARK: - Private methods
    private func customizeNavigationBar() {
        setupTitle("Pokemon List")
        navigationItem.leftBarButtonItems = [makeCloseButton()]
    }

    private func makeCloseButton() -> UIBarButtonItem {
        guard let closeIcon = UIImage.init(systemName: "xmark")?.withRenderingMode(.alwaysTemplate) else { return UIBarButtonItem() }
        let button = UIBarButtonItem(
            image: closeIcon,
            style: .plain,
            target: self,
            action: #selector(tappedOnCloseButton)
        )
        button.tintColor = .BrandColors.pokeballRed
        return button
    }
    
    @objc private func tappedOnCloseButton() {
        delegate?.didCloseFlow()
    }
    
    private func loadPokemons(generationIndex: Int = 0) {
        customView.setLoading(isLoading: true)
        Task {
            await viewModel.getPokemons()
        }
    }
    
    private func showErrorModal(errorMessage: String) {
        let alertAction = UIAlertAction(title: "Try again", style: .cancel) { [weak self] _ in
            guard let self else { return }
            self.loadPokemons()
        }
        delegate?.presentAlert(feedbackMessage: errorMessage, action: alertAction)
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
            delegate?.showPokemonDetails(pokemonName: pokemonName)
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
