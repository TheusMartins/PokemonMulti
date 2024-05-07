//
//  TeamListController.swift
//
//
//  Created by Scizor on 5/6/24.
//

import UIKit

final class TeamListController: UIViewController {
    //MARK: - Private properties
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
    
    //MARK: - Overrides
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTeam()
    }
    
    //MARK: - Private methods
    private func addPokemons() {
        
    }
    
    @objc private func updateTeam() {

    }
}



extension TeamListController: TeamListViewModelDelegate {
    func stateDidChange(state: TeamListViewModel.State) {
        switch state {
        case .didLoadPokemons(let pokemons):
            printContent(pokemons)
        case .couldNotLoadPokemons(let errorMessage):
            print(errorMessage)
        }
    }
}
