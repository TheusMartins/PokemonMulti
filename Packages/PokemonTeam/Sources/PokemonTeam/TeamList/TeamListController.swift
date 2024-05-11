//
//  TeamListController.swift
//
//
//  Created by Scizor on 5/6/24.
//

#if canImport(UIKit)
import UIKit

public final class TeamListController: UIViewController {
    // MARK: - Private properties
    
    private lazy var customView: TeamListView = {
        let view = TeamListView()
        return view
    }()
    
    private let viewModel: TeamListViewModel
    
    private var pokemonControllers: [UIViewController] = []
    
    // MARK: - Overrides
    
    public override func loadView() {
        view = customView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    // MARK: Initialization
    
    public init(viewModel: TeamListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func addPokemonsInview() {
        customView.stackView.removeArrangedSubviews()
        for controller in pokemonControllers {
            customView.stackView.addArrangedSubviews(views: [controller.view])
            addChild(controller)
            controller.didMove(toParent: self)
        }
    }
    
    private func updateTeam(with pokemons: [PokemonModel]) {
        pokemonControllers = []
        pokemons.forEach { model in
            let model = PokemonModel(front: model.front, id: model.id, name: model.name, types: model.types)
            let controller = TeamMemberController(viewModel: .init(pokemon: model))
            controller.delegate = self
            pokemonControllers.append(controller)
        }
        addPokemonsInview()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        Task { await viewModel.getAllLocalPokemons() }
    }
}

extension TeamListController: TeamListViewModelDelegate {
    func stateDidChange(state: TeamListViewModel.State) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch state {
            case .didLoadPokemons(let pokemons):
                updateTeam(with: pokemons)
            case .couldNotLoadPokemons(let errorMessage):
                print(errorMessage)
            }
        }
    }
}

extension TeamListController: TeamMemberControllerDelegate {
    func didDeletePokemon() {
        Task { await viewModel.getAllLocalPokemons() }
    }
}
#endif
