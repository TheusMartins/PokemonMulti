//
//  PokemonListCoordinator.swift
//  
//
//  Created by Scizor on 5/13/24.
//

import Coordinator
import UIKit

public final class PokemonListCoordinator: BaseCoordinator {
    private lazy var controller: PokemonListController = {
        let controller = PokemonListController()
        controller.delegate = self
        return controller
    }()
    
    public override func setupForPresentation() {
        super.setupForPresentation()
        router.setViewControllers([controller], animated: true)
    }
}

extension PokemonListCoordinator: PokemonListCoordinatorDelegate {
    public func didCloseFlow() {
        dismiss(animated: true, completion: nil)
    }
    
    public func showPokemonDetails(pokemonName: String) {
        let viewController = PokemonDetailsController(pokemonName: pokemonName)
        viewController.delegate = self
        router.pushViewController(viewController, animated: true)
    }
    
    public func presentAlert(feedbackMessage: String, action: UIAlertAction) {
        let alert = UIAlertController(title: feedbackMessage, message: nil, preferredStyle: .alert)
        alert.addAction(action)
        router.present(alert, animated: true, completion: nil)
    }
}
