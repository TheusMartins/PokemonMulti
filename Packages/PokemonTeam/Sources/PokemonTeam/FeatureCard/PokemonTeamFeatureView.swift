//
//  PokemonTeamFeatureView.swift
//
//
//  Created by Scizor on 5/11/24.
//

#if canImport(UIKit)
import UIKit
import DesignSystem
import SwiftUI

public final class PokemonTeamFeatureView: UIView {
    private lazy var card: FeatureCardView = {
        let card = FeatureCardView.init(featureName: "Pokemon Team", template: .imageOnRight(.init(named: "featureImage", in: .module, with: nil) ?? UIImage()))
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

extension PokemonTeamFeatureView: ViewConfiguration {
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


private extension CGFloat {
    static var cardMeasure: CGFloat {
        150
    }
}
#endif

public struct PokemonTeamFeatureViewRepresentable: UIViewRepresentable {
    
    public init() { }
    
    public func makeUIView(context: Context) -> UIView {
        return PokemonTeamFeatureView()
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) { }
}
