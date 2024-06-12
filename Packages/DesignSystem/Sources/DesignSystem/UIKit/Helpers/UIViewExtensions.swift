//
//  UIViewExtensions.swift
//
//
//  Created by Scizor on 5/6/24.
//

#if canImport(UIKit)
import UIKit

public extension UIView {
    func addSubViews(views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
#endif
