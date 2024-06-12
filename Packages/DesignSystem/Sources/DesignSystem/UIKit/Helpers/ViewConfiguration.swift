//
//  ViewConfiguration.swift
//  
//
//  Created by Scizor on 5/6/24.
//

public protocol ViewConfiguration {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
    func setupViewConfiguration()
}

public extension ViewConfiguration {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func configureViews() {}
}
