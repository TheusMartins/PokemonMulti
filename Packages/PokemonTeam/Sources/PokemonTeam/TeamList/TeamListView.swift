//
//  TeamListView.swift
//  
//
//  Created by Scizor on 5/6/24.
//

#if canImport(UIKit)
import UIKit
import DesignSystem

final class TeamListView: UIView {
    //MARK: - Private properties
    private let scrollView = UIScrollView()
    
    //MARK: - Public properties
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = .Measure.measure24
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ViewConfiguration
extension TeamListView: ViewConfiguration {
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
    
    func configureViews() {
        backgroundColor = .BackgroundColors.backgroundColor
        scrollView.backgroundColor = .BackgroundColors.backgroundColor
    }
}
#endif
