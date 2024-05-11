//
//  FeatureListController.swift
//  Pokemon
//
//  Created by Scizor on 4/25/24.
//

import UIKit
import PokemonListing
import PokemonTeam

final class FeatureListController: UIViewController {
    private lazy var customView: PokemonTeamGeneralView = {
        let view = PokemonTeamGeneralView()
        view.delegate = self
        return view
    }()

    override func loadView() {
        view = customView
    }
}

extension FeatureListController: PokemonTeamGeneralViewDelegate {
    func didTrigger(action: PokemonTeamGeneralView.Actions) {
        switch action {
        case .didTapOnListingFeature:
            let controller = PokemonListController()
            navigationController?.pushViewController(controller, animated: true)
        case .didTapOnTeamFeature:
            let controller = TeamListController(viewModel: .init())
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
