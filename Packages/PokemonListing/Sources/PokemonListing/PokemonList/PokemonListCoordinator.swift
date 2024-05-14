//
//  PokemonListCoordinator.swift
//  
//
//  Created by Scizor on 5/13/24.
//

import Coordinator
import UIKit

final class PokemonListCoordinator: BaseCoordinator {
    override func setupForPresentation() {
        super.setupForPresentation()
        let viewController = PokemonListController()
        viewController.delegate = self
        router.setViewControllers([viewController], animated: true)
    }
}

extension PokemonListCoordinator: PokemonListCoordinatorDelegate {
    func showPokemonDetails(pokemonName: String) {
        let viewController = PokemonDetailsController(pokemonName: pokemonName)
        viewController.delegate = self
        router.pushViewController(viewController, animated: true)
    }
    
    func presentAlert(feedbackMessage: String, action: UIAlertAction) {
        let alert = UIAlertController(title: feedbackMessage, message: nil, preferredStyle: .alert)
        alert.addAction(action)
        router.present(alert, animated: true, completion: nil)
    }
}
