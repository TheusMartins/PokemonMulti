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
    
    private lazy var viewModel: TeamListViewModel = {
        let viewModel = TeamListViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    private var pokemonControllers: [UIViewController] = []
    
    // MARK: - Overrides
    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task { await viewModel.getAllLocalPokemons() }
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
