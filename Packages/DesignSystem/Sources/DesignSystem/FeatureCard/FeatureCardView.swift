//
//  FeatureCardView.swift
//
//
//  Created by Scizor on 5/11/24.
//

import UIKit

public final class FeatureCardView: UIView {
    public enum Templates {
        case imageOnLeft(UIImage)
        case imageOnRight(UIImage)
    }
    
    private lazy var infosStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
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
        let label = Text(type: .heading01)
        return label
    }()
    
    public init(featureName: String, template: FeatureCardView.Templates) {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(with featureName: String, in template: FeatureCardView.Templates) {
        featureNameLabel.text = featureName
        switch template {
        case .imageOnLeft(let uIImage):
            featureImage.image = uIImage
            infosStackView.addArrangedSubviews(views: [
                featureImage,
                featureNameLabel
            ])
            featureNameLabel.textAlignment = .right
        case .imageOnRight(let uIImage):
            featureImage.image = uIImage
            infosStackView.addArrangedSubviews(views: [
                featureNameLabel,
                featureImage
            ])
            featureNameLabel.textAlignment = .left
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
            featureImage.heightAnchor.constraint(equalToConstant: .imageMeasure),
            featureImage.widthAnchor.constraint(equalToConstant: .imageMeasure)
        ])
    }
    
    public func configureViews() {
        backgroundColor = .BackgroundColors.backgroundColor
    }
}

private extension CGFloat {
    static var imageMeasure: CGFloat {
        150
    }
}
