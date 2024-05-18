//
//  FeatureListCoordinator.swift
//  Pokemon
//
//  Created by Scizor on 5/13/24.
//

import Coordinator
import PokemonListing
import PokemonTeam
import UIKit

final class FeatureListCoordinator: BaseCoordinator {
    private lazy var controller: FeatureListController = {
        let controller = FeatureListController()
        controller.delegate = self
        return controller
    }()
    
    override func setupForPresentation() {
        super.setupForPresentation()
        router.setViewControllers([controller], animated: true)
    }
}

extension FeatureListCoordinator: FeatureListControllerDelegate {
    func didTapOnPokemonList() {
        let coordinator = PokemonListCoordinator.init(router: RouterImplementation(modalPresentationStyle: .fullScreen))
        presentChild(coordinator, animated: true, onDismissed: nil)
    }
    
    func didTapOnTeamList() {
        let coordinator = TeamListCoordinator(dependencies: nil, router: RouterImplementation(modalPresentationStyle: .fullScreen))
        presentChild(coordinator, animated: true, onDismissed: nil)
    }
}
