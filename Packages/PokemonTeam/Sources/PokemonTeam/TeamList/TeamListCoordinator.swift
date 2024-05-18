//
//  TeamListCoordinator.swift
//
//
//  Created by Scizor on 5/13/24.
//

import Coordinator
import UIKit

public final class TeamListCoordinator: BaseCoordinator {
    
    private lazy var controller: TeamListController = {
        let controller = TeamListController(viewModel: .init())
        controller.delegate = self
        return controller
    }()
    
    private let dependencies: PokemonStoreRetrieve?
    
    public init(dependencies: PokemonStoreRetrieve?, router: Router) {
        self.dependencies = dependencies
        super.init(router: router)
    }
    
    public override func setupForPresentation() {
        super.setupForPresentation()
        router.setViewControllers([controller], animated: true)
    }
}

extension TeamListCoordinator: AlertDelegate {
    public func presentAlert(feedbackMessage: String, action: UIAlertAction) {
        let alert = UIAlertController(title: feedbackMessage, message: nil, preferredStyle: .alert)
        alert.addAction(action)
        router.present(alert, animated: true, completion: nil)
    }
}

extension TeamListCoordinator: TeamListControllerDelegate {
    func didCloseFlow() {
        dismiss(animated: true, completion: nil)
    }
}
