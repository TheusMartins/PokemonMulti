//
//  SecondaryButton.swift
//
//
//  Created by Scizor on 5/2/24.
//

import UIKit

final public class SecondaryButton: UIButton {
    
    public var layout: SecondaryButton.Layout = .wide {
        didSet { setHeight() }
    }

    public override var isEnabled: Bool {
        didSet { setLayout() }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    public init(layout: SecondaryButton.Layout) {
        self.layout = layout
        super.init(frame: .zero)
        setLayout()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setHeight()
    }

    private func setHeight() {
        NSLayoutConstraint.activate([self.heightAnchor.constraint(equalToConstant: layout.height)])
    }

    private func setLayout() {
        self.backgroundColor = .BrandColors.pokeballRed
        self.layer.cornerRadius = layout.cornerRadius
        self.titleLabel?.font = UIFont.fontType(.button)
        self.layer.borderWidth = .Measure.measure1
        self.layer.borderColor = UIColor.BrandColors.pikachuYellow.cgColor
        self.setTitleColor(self.isEnabled ? .TextColors.textPrimary : .TextColors.textDisabled, for: .normal)
    }
}

extension SecondaryButton {
    public enum Layout {
        case wide
        case thin

        var cornerRadius: CGFloat {
            switch self {
            case .wide,
                 .thin:
                return CGFloat(.Measure.measure8)
            }
        }

        var height: CGFloat {
            switch self {
            case .wide: return CGFloat(.Measure.measure48)
            case .thin: return CGFloat(.Measure.measure40)
            }
        }
    }
}
