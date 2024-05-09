//
//  PokemonDetailsView.swift
//
//
//  Created by Scizor on 5/8/24.
//

import UIKit
import DesignSystem

protocol PokemonDetailsViewDelegate: AnyObject {
    func didTrigger(action: PokemonDetailsView.Actions)
}

final class PokemonDetailsView: UIView {
    // MARK: - Open properties
    
    enum Actions {
        case didTapOnAddPokemon
    }
    
    weak var delegate: PokemonDetailsViewDelegate?
    
    // MARK: - Private properties
    
    private lazy var pokemonInfosStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = .Measure.measure16
        return stack
    }()
    
    private lazy var imageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = .Measure.measure16
        return stack
    }()
    private lazy var frontImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = .imageRadius
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nationalDexIdLabel: Text = {
        let label = Text(type: .body)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pokemonTypesLabel: Text = {
        let label = Text(type: .body)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var spinnerLoader: SpinnerLoader = {
        let loader = SpinnerLoader()
        loader.color = .BrandColors.pikachuYellow
        return loader
    }()
    
    
    private lazy var addPokemonButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .BrandColors.pikachuYellow
        button.layer.cornerRadius = .Measure.measure8
        button.setTitle("Add in your Team", for: .normal)
        button.addTarget(self, action: #selector(addPokemon), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setupInfos(with model: PokemonDetailsModel) {
        nationalDexIdLabel.text = "National dex id: \(model.id)"
        pokemonTypesLabel.text = "Type: "
        for type in model.types {
            pokemonTypesLabel.text! += type.type.name.capitalized + " "
        }
        frontImage.showLoading()
        
    }
    
    func setupImages(front: UIImage, hasError: Bool) {
        if hasError { frontImage.tintColor = .white }
        frontImage.hideLoading()
        frontImage.image = front
    }
    
    func setLoading(isLoading: Bool) {
        spinnerLoader.isHidden = !isLoading
        addPokemonButton.isHidden = isLoading
        isLoading ? spinnerLoader.startAnimation() : spinnerLoader.stopAnimating()
        
    }
    
    // MARK: - Private methods
    @objc private func addPokemon() {
        delegate?.didTrigger(action: .didTapOnAddPokemon)
    }
}

// MARK: - ViewConfiguration

extension PokemonDetailsView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [
            imageStackView,
            pokemonInfosStack,
            addPokemonButton,
            spinnerLoader
        ])
        imageStackView.addArrangedSubviews(views: [frontImage])
        pokemonInfosStack.addArrangedSubviews(views: [nationalDexIdLabel, pokemonTypesLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .Measure.measure24),
            imageStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .Measure.measure24),
            imageStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.Measure.measure24),
            imageStackView.heightAnchor.constraint(equalToConstant: .stackHeight),
        
            pokemonInfosStack.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: .Measure.measure24),
            pokemonInfosStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .Measure.measure24),
            pokemonInfosStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.Measure.measure24),
            pokemonInfosStack.bottomAnchor.constraint(lessThanOrEqualTo: addPokemonButton.topAnchor),

            addPokemonButton.heightAnchor.constraint(equalToConstant: .Measure.measure40),
            addPokemonButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .Measure.measure24),
            addPokemonButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.Measure.measure24),
            addPokemonButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -.Measure.measure24),
            
            spinnerLoader.heightAnchor.constraint(equalToConstant: .Measure.measure56),
            spinnerLoader.widthAnchor.constraint(equalToConstant: .Measure.measure56),
            spinnerLoader.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinnerLoader.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func configureViews() {
        backgroundColor = .BackgroundColors.backgroundColor
    }
}

private extension CGFloat {
    static var stackHeight: CGFloat {
        150
    }
    
    static var imageRadius: CGFloat {
        .Measure.measure56 / 2
    }

}
