//
//  FeatureListController.swift
//  Pokemon SwiftUI
//
//  Created by Scizor on 6/12/24.
//

import UIKit
import SwiftUI
import DesignSystem

protocol FeatureListControllerDelegate: AnyObject {
    func didTapOnPokemonList()
    func didTapOnTeamList()
}

final class FeatureListController: UIViewController {
    
    // MARK: - Open properties
    
    weak var delegate: FeatureListControllerDelegate?
    
    // MARK: - Private properties
    
    private lazy var contentView: FeatureListView = {
        var view = FeatureListView()
        view.didTapOn = { [weak self] action in
            guard let self else { return }
            handle(action: action)
        }
        return view
    }()
    
    private lazy var contentController = UIHostingController(rootView: contentView)

    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfiguration()
        setupTitle("Feature List")
    }
    
    // MARK: - Private methods
    
    private func handle(action: FeatureListView.Action) {
        switch action {
        case .didTapOnListing:
            delegate?.didTapOnPokemonList()
        case .didTapOnTeam:
            delegate?.didTapOnTeamList()
        }
    }
}

extension FeatureListController: ViewConfiguration {
    func buildViewHierarchy() {
        addChild(contentController)
        view.addSubview(contentController.view)
        contentController.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentController.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
