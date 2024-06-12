//
//  FeatureListCoordinator.swift
//  Pokemon SwiftUI
//
//  Created by Scizor on 6/12/24.
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

extension FeatureListCoordinator: FeatureListControllerDelegate  {
    func didTapOnPokemonList() {
        print("Banana")
    }
    
    func didTapOnTeamList() {
        print("Patel")
    }
}

