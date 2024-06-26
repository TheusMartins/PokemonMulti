//
//  PokemonListingFeatureView.swift
//
//
//  Created by Scizor on 5/11/24.
//

#if canImport(UIKit)
import UIKit
import SwiftUI
import DesignSystem

public final class PokemonListingFeatureView: UIView {
    private lazy var card: FeatureCardView = {
        let card = FeatureCardView.init(featureName: "Pokemon Listing", template: .imageOnLeft(.init(named: "imageFeature", in: .module, with: nil) ?? UIImage()))
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    public init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonListingFeatureView: ViewConfiguration {
    public func buildViewHierarchy() {
        addSubview(card)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            // card
            card.topAnchor.constraint(equalTo: topAnchor),
            card.leadingAnchor.constraint(equalTo: leadingAnchor),
            card.trailingAnchor.constraint(equalTo: trailingAnchor),
            card.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            heightAnchor.constraint(equalToConstant: .cardMeasure)
        ])
    }
    
    public func configureViews() {
        backgroundColor = .BackgroundColors.backgroundColor
    }
}

public extension CGFloat {
    static var cardMeasure: CGFloat {
        150
    }
}
#endif

public struct PokemonListingFeatureViewRepresentable: UIViewRepresentable {
    public init() { }
    
    public func makeUIView(context: Context) -> UIView {
        return PokemonListingFeatureView()
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) { }
}
