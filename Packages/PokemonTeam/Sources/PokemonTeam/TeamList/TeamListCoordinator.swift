//
//  TeamListCoordinator.swift
//
//
//  Created by Scizor on 5/13/24.
//

import Coordinator
import UIKit

public final class TeamListCoordinator: BaseCoordinator {
    
    private let dependencies: PokemonStoreRetrieve
    
    init(dependencies: PokemonStoreRetrieve, router: Router = RouterImplementation()) {
        self.dependencies = dependencies
        super.init(router: router)
    }
    
    public override func setupForPresentation() {
        super.setupForPresentation()
        let viewController = TeamListController(viewModel: .init(store: dependencies))
        viewController.delegate = self
        router.setViewControllers([viewController], animated: true)
    }
}

extension TeamListCoordinator: TeamListControllerDelegate {
    func presentAlert(feedbackMessage: String, action: UIAlertAction) {
        let alert = UIAlertController(title: feedbackMessage, message: nil, preferredStyle: .alert)
        alert.addAction(action)
        router.present(alert, animated: true, completion: nil)
    }
}
