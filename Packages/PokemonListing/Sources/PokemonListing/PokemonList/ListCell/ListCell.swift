//
//  ListCell.swift
//
//
//  Created by Scizor on 5/8/24.
//

#if canImport(UIKit)
import UIKit
import DesignSystem
import RemoteImages

final class ListCell: UITableViewCell {
    //MARK: - Private properties
    private let pokemonImage: RemoteImageView = {
        let image = RemoteImageView(frame: .zero)
        image.layer.cornerRadius = .cornerRadius
        image.clipsToBounds = true
        return image
    }()
    
    private let pokemonName: Text = {
        let label = Text(type: .labelStatic)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImage.removeFromSuperview()
        pokemonName.removeFromSuperview()
    }
    
    //MARK: - Public methods
    func setupInfos(with pokemon: PokemonModel) {
        pokemonImage.image = nil
        pokemonName.text = pokemon.name.capitalized
        pokemonImage.showLoading()
        pokemonImage.pokemonId = pokemon.url.absoluteString.split(whereSeparator: { $0 == "/"}).map(String.init).last ?? ""
        setupViewConfiguration()
    }
}

//MARK: - ViewConfiguration
extension ListCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [pokemonImage, pokemonName])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //pokemonImage
            pokemonImage.topAnchor.constraint(equalTo: topAnchor, constant: .Measure.measure12),
            pokemonImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .Measure.measure24),
            pokemonImage.trailingAnchor.constraint(equalTo: pokemonName.leadingAnchor, constant: -.Measure.measure16),
            pokemonImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.Measure.measure12),
            pokemonImage.heightAnchor.constraint(equalToConstant: .Measure.measure96),
            pokemonImage.widthAnchor.constraint(equalToConstant: .Measure.measure96),
    
            //pokemonName
            pokemonName.topAnchor.constraint(equalTo: topAnchor, constant: .Measure.measure16),
            pokemonName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.Measure.measure24),
            pokemonName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.Measure.measure16),
        ])
    }
    
    func configureViews() {
        backgroundColor = .BackgroundColors.backgroundColor
        selectionStyle = .none
    }
}


private extension CGFloat {
    static var cornerRadius: CGFloat {
        26
    }
}
#endif
