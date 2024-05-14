//
//  TeamListCoordinator.swift
//
//
//  Created by Scizor on 5/13/24.
//

import Coordinator

public final class TeamListCoordinator: BaseCoordinator {
    
    private let dependencies: PokemonStoreRetrieve
    
    init(dependencies: PokemonStoreRetrieve, router: Router = RouterImplementation()) {
        self.dependencies = dependencies
        super.init(router: router)
    }
    
    public override func setupForPresentation() {
        super.setupForPresentation()
        let viewController = TeamListController(viewModel: .init(store: dependencies))
        router.setViewControllers([viewController], animated: true)
    }
}
