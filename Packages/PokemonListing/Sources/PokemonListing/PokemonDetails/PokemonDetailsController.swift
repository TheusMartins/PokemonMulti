//
//  PokemonDetailsController.swift
//
//
//  Created by Scizor on 5/8/24.
//

#if canImport(UIKit)
import UIKit
import DesignSystem

final class PokemonDetailsController: UIViewController {
    // MARK: - Private properties
    
    private let viewModel: PokemonDetailsViewModel
    private lazy var customView: PokemonDetailsView = {
        let view = PokemonDetailsView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Initialization
    init(pokemonName: String) {
        self.viewModel = PokemonDetailsViewModel(pokemonName: pokemonName)
        super.init(nibName: nil, bundle: nil)
        self.setupTitle(pokemonName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        loadPokemonInfos()
    }
    
    //MARK: - Private methods
    private func loadPokemonInfos() {
        customView.setLoading(isLoading: true)
        Task { await viewModel.getPokemon() }
    }
    
    private func showErrorModal(feedbackMessage: String) {
        let alert = UIAlertController(title: feedbackMessage, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Try again", style: .cancel) { [weak self] _ in
            self?.loadPokemonInfos()
        }
        alert.addAction(alertAction)
        navigationController?.present(alert, animated: true, completion: nil)
        
    }
}

extension PokemonDetailsController: PokemonDetailsViewModelDelegate {
    func didChange(state: PokemonDetailsViewModel.State) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            customView.setLoading(isLoading: false)
            switch state {
            case .didLoadDetails(let pokemonDetail):
                customView.setupInfos(with: pokemonDetail)
            case .errorOnLoadPokemon(let feedbackMessage):
                showErrorModal(feedbackMessage: feedbackMessage)
            case .addedPokemon(let feedbackMessage), .errorOnAddPokemon(let feedbackMessage):
                let alert = UIAlertController(title: feedbackMessage, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                navigationController?.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension PokemonDetailsController: PokemonDetailsViewDelegate {
    func didTrigger(action: PokemonDetailsView.Actions) {
        switch action {
        case .didTapOnAddPokemon(let imageData):
            Task { await viewModel.addPokemon(imageData: imageData) }
        }
    }
}
#endif
