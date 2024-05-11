//
//  TeamMemberView.swift
//
//
//  Created by Scizor on 5/6/24.
//

#if canImport(UIKit)
import DesignSystem
import UIKit

protocol TeamMemberViewDelegate: AnyObject {
    func didTrigger(action: TeamMemberView.Actions)
}

final class TeamMemberView: UIView {
    // MARK: - Open properties
    enum Actions {
        case didTapOnDelete
    }
    
    weak var delegate: TeamMemberViewDelegate?
    
    // MARK: - Private properties
    
    private lazy var pokemonInfosStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = .Measure.measure16
        return stack
    }()
    
    private lazy var imagesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = .Measure.measure16
        return stack
    }()
    
    private lazy var frontImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = .radius
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nationalDexIdLabel: Text = {
        let label = Text(type: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pokemonTypesLabel: Text = {
        let label = Text(type: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Public methods
    private lazy var trashButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        let image = UIImage(systemName: .trashIcon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(didTapOnTrash), for: .touchUpInside)
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
    
    func setupInfos(with model: PokemonModel) {
        nationalDexIdLabel.text = "National dex number: \(model.id)"
        pokemonTypesLabel.text = "Type: "
        for type in model.types ?? [] {
            pokemonTypesLabel.text! += type + " "
        }
        guard let imageData = model.front else { return }
        frontImage.image = UIImage(data: imageData)
    }
    
    // MARK: - Private methods
    
    @objc private func didTapOnTrash() {
        delegate?.didTrigger(action: .didTapOnDelete)
    }
}

// MARK: - ViewConfiguration
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
#endif
