//
//  TeamListView.swift
//  
//
//  Created by Scizor on 5/6/24.
//


import UIKit
import DesignSystem

final class PokemonTeamGeneralView: UIView {
    //MARK: - Private properties
    private let scrollView = UIScrollView()
    
    //MARK: - Public properties
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .Measure.measure24
        stackView.axis = .vertical
        return stackView
    }()
    
    //MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ViewConfiguration
extension PokemonTeamGeneralView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [scrollView])
        scrollView.addSubViews(views: [stackView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -.Measure.measure24),
            stackView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    func configureViews() { }
}

protocol ViewConfiguration {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
    func setupViewConfiguration()
}

extension ViewConfiguration {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func configureViews() {}
}

extension UIView {
    func addSubViews(views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
