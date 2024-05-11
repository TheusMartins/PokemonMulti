//
//  UIViewControllerExtensions.swift
//
//
//  Created by Scizor on 5/8/24.
//

#if canImport(UIKit)
import UIKit


public extension UIViewController {
    func setupTitle(_ title: String?, color: UIColor = .white) {
        let text = Text(type: .heading04)
        text.text = title?.capitalized
        self.navigationItem.titleView = text
    }
}
#endif
