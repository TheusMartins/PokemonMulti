//
//  UIStackViewExtensions.swift
//
//
//  Created by Scizor on 5/6/24.
//

#if canImport(UIKit)
import UIKit

public extension UIStackView {
    func addArrangedSubviews(views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(view)
        }
    }
    
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
#endif
