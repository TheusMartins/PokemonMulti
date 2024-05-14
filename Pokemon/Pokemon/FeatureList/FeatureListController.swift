//
//  FeatureListController.swift
//  Pokemon
//
//  Created by Scizor on 4/25/24.
//

import UIKit

protocol FeatureListControllerDelegate: AnyObject {
    func didTapOnPokemonList()
    func didTapOnTeamList()
}

final class FeatureListController: UIViewController {
    // MARK: - Open properties
    weak var delegate: FeatureListControllerDelegate?
    
    // MARK: - Private properties
    
    private lazy var customView: PokemonTeamGeneralView = {
        let view = PokemonTeamGeneralView()
        view.delegate = self
        return view
    }()

    // MARK: - Overrides
    
    override func loadView() {
        view = customView
    }
}

extension FeatureListController: PokemonTeamGeneralViewDelegate {
    func didTrigger(action: PokemonTeamGeneralView.Actions) {
        switch action {
        case .didTapOnListingFeature:
            delegate?.didTapOnPokemonList()
        case .didTapOnTeamFeature:
            delegate?.didTapOnTeamList()
        }
    }
}
