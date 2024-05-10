//
//  TeamListController.swift
//
//
//  Created by Scizor on 5/6/24.
//

import UIKit

final class TeamListController: UIViewController {
    // MARK: - Private properties
    
    private lazy var customView: TeamListView = {
        let view = TeamListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewModel: TeamListViewModel
    
    private var pokemonControllers: [UIViewController] = []
    
    // MARK: - Overrides
    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    // MARK: Initialization
    
    init(viewModel: TeamListViewModel) {
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
        switch state {
        case .didLoadPokemons(let pokemons):
            updateTeam(with: pokemons)
        case .couldNotLoadPokemons(let errorMessage):
            print(errorMessage)
        }
    }
}
