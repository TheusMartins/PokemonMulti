//
//  PrimaryButton.swift
//
//
//  Created by Scizor on 5/2/24.
//

import UIKit

public final class PrimaryButton: UIButton {
    public var layout: PrimaryButton.Layout = .wide {
        didSet { setHeight() }
    }

    public override var isEnabled: Bool {
        didSet { setLayout() }
    }

    private var spinner: SpinnerLoader = {
        let spinner = SpinnerLoader()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    private var title: String?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setSpinner()
    }

    public init(layout: PrimaryButton.Layout) {
        self.layout = layout
        super.init(frame: .zero)
        setLayout()
        setSpinner()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setHeight()
    }

    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        self.title = title
    }

    public override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        super.addTarget(target, action: action, for: controlEvents)
        let tapGeture = UITapGestureRecognizer(target: target, action: action)
        spinner.addGestureRecognizer(tapGeture)
    }

    public func startLoader() {
        super.setTitle("", for: .normal)
        self.isUserInteractionEnabled = false
        spinner.startAnimation()
    }

    public func stopLoader() {
        spinner.stopAnimating()
        self.isUserInteractionEnabled = true
        setTitle(self.title, for: .normal)
    }

    private func setHeight() {
        NSLayoutConstraint.activate([self.heightAnchor.constraint(equalToConstant: layout.height)])
    }

    private func setLayout() {
        self.backgroundColor = self.isEnabled ? .BrandColors.pikachuYellow : .darkGray
        self.isUserInteractionEnabled = isEnabled
        self.layer.cornerRadius = layout.cornerRadius
        self.titleLabel?.font = UIFont.fontType(.button)
        self.setTitleColor(self.isEnabled ? .TextColors.textPrimary : .TextColors.textDisabled, for: .normal)
    }

    private func setSpinner() {
        addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: .Measure.measure32),
            spinner.heightAnchor.constraint(equalToConstant: .Measure.measure32),
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

extension PrimaryButton {

    public enum Layout {
        case wide
        case thin
        case fixed

        var cornerRadius: CGFloat {
            switch self {
            case .wide,
                 .thin:
                return CGFloat(.Measure.measure8)
            default: return .zero
            }
        }

        var height: CGFloat {
            switch self {
            case .wide: return CGFloat(.Measure.measure48)
            case .thin: return CGFloat(.Measure.measure40)
            case .fixed: return CGFloat(.Measure.measure56)
            }
        }
    }
}
