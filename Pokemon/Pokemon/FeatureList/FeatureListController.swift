//
//  FeatureListController.swift
//  Pokemon
//
//  Created by Scizor on 4/25/24.
//

import UIKit

class FeatureListController: UIViewController {
    private lazy var customView: PokemonTeamGeneralView = {
        let view = PokemonTeamGeneralView()
        
        return view
    }()

    override func loadView() {
        view = customView
    }
}

