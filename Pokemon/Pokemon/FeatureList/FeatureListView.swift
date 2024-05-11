//
//  FeatureListView.swift
//  Pokemon
//
//  Created by Scizor on 5/11/24.
//

import UIKit
import DesignSystem
import PokemonListing
import PokemonTeam

final class PokemonTeamGeneralView: UIView {
    // MARK: - Private properties
    private lazy var scrollView = UIScrollView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = .Measure.measure24
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var pokemonListCard: PokemonListingFeatureView = {
        let card = PokemonListingFeatureView()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    private lazy var pokemonTeamCard: PokemonTeamFeatureView = {
        let card = PokemonTeamFeatureView()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewConfiguration
extension PokemonTeamGeneralView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [scrollView])
        scrollView.addSubViews(views: [stackView])
        stackView.addArrangedSubviews(views: [
            pokemonListCard,
            pokemonTeamCard
        ])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -.Measure.measure24),
            stackView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    func configureViews() {
        backgroundColor = .BackgroundColors.backgroundColor
    }
}
