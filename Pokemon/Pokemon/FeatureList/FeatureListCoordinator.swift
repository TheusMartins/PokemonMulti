//
//  FeatureListCoordinator.swift
//  Pokemon
//
//  Created by Scizor on 5/13/24.
//

import Coordinator
import PokemonListing
import PokemonTeam

final class FeatureListCoordinator: BaseCoordinator {
    override func setupForPresentation() {
        super.setupForPresentation()
        let controller = FeatureListController()
        router.setViewControllers([controller], animated: true)
    }
}

extension FeatureListCoordinator: FeatureListControllerDelegate {
    func didTapOnPokemonList() {
        let controller = PokemonListController()
        router.pushViewController(controller, animated: true)
    }
    
    func didTapOnTeamList() {
        let controller = TeamListController(viewModel: .init())
        router.pushViewController(controller, animated: true)
    }
}
