//
//  UIImageViewExtensions.swift
//  
//
//  Created by Scizor on 5/8/24.
//

#if canImport(UIKit)
import UIKit

public extension UIImageView {
    func showLoading() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        self.addSubViews(views: [activityIndicator])
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        guard let activityIndicator = subviews.last as? UIActivityIndicatorView else { return }
        
        activityIndicator.removeFromSuperview()
    }
}
#endif
