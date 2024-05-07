//
//  TeamMemberView.swift
//
//
//  Created by Scizor on 5/6/24.
//

import DesignSystem
import UIKit

final class TeamMemberView: UIView {
    //MARK: - Private properties
    private let pokemonInfosStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = .Measure.measure16
        return stack
    }()
    
    private let imagesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = .Measure.measure16
        return stack
    }()
    private let frontImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = .radius
        image.clipsToBounds = true
        return image
    }()
    
    private let nationalDexIdLabel: Text = {
        let label = Text(type: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let pokemonTypesLabel: Text = {
        let label = Text(type: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Public methods
    let trashButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        let image = UIImage(systemName: .trashIcon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .red
        return button
    }()
    
    //MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    func setupInfos(with model: PokemonModel) {
        nationalDexIdLabel.text = "National dex number: \(model.id)"
        pokemonTypesLabel.text = "Type: "
        for type in model.types ?? [] {
            pokemonTypesLabel.text! += type + " "
        }
        guard let imageData = model.front else { return }
        frontImage.image = UIImage(data: imageData)
        
    }
}

//MARK: - ViewConfiguration
extension TeamMemberView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [
            trashButton,
            imagesStackView,
            pokemonInfosStack
        ])
        
        bringSubviewToFront(trashButton)
        imagesStackView.addArrangedSubviews(views: [frontImage])
        pokemonInfosStack.addArrangedSubviews(views: [nationalDexIdLabel, pokemonTypesLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            trashButton.topAnchor.constraint(equalTo: topAnchor, constant: .Measure.measure24),
            trashButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.Measure.measure24),
            trashButton.heightAnchor.constraint(equalToConstant: .Measure.measure24),
            trashButton.widthAnchor.constraint(equalToConstant: .Measure.measure24),
            
            imagesStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .Measure.measure24),
            imagesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .Measure.measure24),
            imagesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.Measure.measure24),
            imagesStackView.heightAnchor.constraint(equalToConstant: .imageHeight),
        
            pokemonInfosStack.topAnchor.constraint(equalTo: imagesStackView.bottomAnchor, constant: .Measure.measure24),
            pokemonInfosStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .Measure.measure24),
            pokemonInfosStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.Measure.measure24),
            pokemonInfosStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -.Measure.measure24)
        ])
    }
    
    func configureViews() {
        backgroundColor = .BackgroundColors.backgroundColor
    }
}

private extension CGFloat {
    static var radius: CGFloat = 26
    static var imageHeight: CGFloat = 150
}

private extension String {
    static var trashIcon: String = "trash"
}
