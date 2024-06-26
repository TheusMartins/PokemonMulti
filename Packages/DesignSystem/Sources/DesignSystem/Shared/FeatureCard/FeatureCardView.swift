//
//  FeatureCardView.swift
//
//
//  Created by Scizor on 5/11/24.
//

import SwiftUI
#if canImport(UIKit)
import UIKit

public final class FeatureCardView: UIView {
    public enum Templates {
        case imageOnLeft(UIImage)
        case imageOnRight(UIImage)
    }
    
    private lazy var infosStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.spacing = .Measure.measure16
        return stack
    }()
    
    private lazy var featureImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var featureNameLabel: Text = {
        let label = Text(type: .heading02)
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    public init(featureName: String, template: FeatureCardView.Templates) {
        super.init(frame: .zero)
        setupViewConfiguration()
        setupLayout(with: featureName, in: template)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupLayout(with featureName: String, in template: FeatureCardView.Templates) {
        featureNameLabel.text = featureName
        switch template {
        case .imageOnLeft(let uIImage):
            featureImage.image = uIImage
            infosStackView.addArrangedSubviews(views: [
                featureImage,
                featureNameLabel
            ])
        case .imageOnRight(let uIImage):
            featureImage.image = uIImage
            infosStackView.addArrangedSubviews(views: [
                featureNameLabel,
                featureImage
            ])
        }
    }
}

extension FeatureCardView: ViewConfiguration {
    public func buildViewHierarchy() {
        addSubview(infosStackView)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            // infosStackView
            infosStackView.topAnchor.constraint(equalTo: topAnchor),
            infosStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .Measure.measure24),
            infosStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.Measure.measure24),
            infosStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // featureImage
            featureImage.heightAnchor.constraint(equalToConstant: .imageMeasure)
        ])
    }
    
    public func configureViews() {
        backgroundColor = .BackgroundColors.backgroundColor
    }
}

private extension CGFloat {
    static var imageMeasure: CGFloat {
        100
    }
}
#endif

struct FeatureCardViewWrapper: UIViewRepresentable {
    var featureName: String
    var template: FeatureCardView.Templates

    func makeUIView(context: Context) -> FeatureCardView {
        return FeatureCardView(featureName: featureName, template: template)
    }

    func updateUIView(_ uiView: FeatureCardView, context: Context) {
        uiView.setupLayout(with: featureName, in: template)
    }
}
