//
//  PokemonListView.swift
//
//
//  Created by Scizor on 5/8/24.
//

#if canImport(UIKit)
import UIKit
import DesignSystem

protocol PokemonListViewDelegate: AnyObject {
    func didTriggerAction(action: PokemonListView.Actions)
}

final class PokemonListView: UIView {
    struct ViewModel {
        let generations: [String]
        var pokemons: [PokemonModel]
    }
    
    enum Actions {
        case didChangeGeneration(generationIndex: Int)
        case didSelectPokemon(pokemonName: String)
    }
    
    // MARK: - Open properties
    
    weak var delegate: PokemonListViewDelegate?
    var viewModel: PokemonListView.ViewModel {
        didSet {
            picker.viewModel = viewModel.generations
            if titleLabel.text == "Select generation" {
                titleLabel.text = viewModel.generations.first
            }
            tableView.reloadData()
        }
    }
    
    // MARK: - Private properties
    
    private lazy var titleLabel: Text = {
        let label = Text(type: .heading02)
        label.text = "Select generation"
        return label
    }()
    
    private lazy var showPickerButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .BrandColors.pokeballRed
        return button
    }()
    
    private lazy var spinnerLoader: SpinnerLoader = {
        let loader = SpinnerLoader()
        loader.color = .BrandColors.pokeballRed
        return loader
    }()
    
    //MARK: - Public properties
    var tableViewTopAnchor: NSLayoutConstraint?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .BackgroundColors.backgroundColor
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var picker: GenerationPickerView = {
        let picker = GenerationPickerView(viewModel: [])
        picker.delegate = self
        return picker
    }()
    
    //MARK: - Initialization
    init(
        viewModel: PokemonListView.ViewModel
    ) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        tableViewTopAnchor = tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: .Measure.measure64)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setupshowPickerButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showPicker))
        showPickerButton.addGestureRecognizer(tap)
    }
    
    @objc private func showPicker() {
        addSubViews(views: [picker])
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - Public methods
    func setLoading(isLoading: Bool) {
        spinnerLoader.isHidden = !isLoading
        tableView.isHidden = isLoading
        isLoading ? spinnerLoader.startAnimation() : spinnerLoader.stopAnimating()
    }
    
    func setupGenerationTitle(title: String) {
        titleLabel.text = title
    }
}

//MARK: - ViewConfiguration
extension PokemonListView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [titleLabel, showPickerButton, tableView, spinnerLoader])
    }
    
    func setupConstraints() {
        guard let searchTextFieldTop = tableViewTopAnchor else { return }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .Measure.measure24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .Measure.measure24),
            
            showPickerButton.heightAnchor.constraint(equalToConstant: .Measure.measure24),
            showPickerButton.widthAnchor.constraint(equalToConstant: .Measure.measure24),
            showPickerButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            showPickerButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: .Measure.measure12),
            
            searchTextFieldTop,
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            spinnerLoader.heightAnchor.constraint(equalToConstant: .Measure.measure56),
            spinnerLoader.widthAnchor.constraint(equalToConstant: .Measure.measure56),
            spinnerLoader.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            spinnerLoader.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func configureViews() {
        self.backgroundColor = .BackgroundColors.backgroundColor
        setupshowPickerButton()
    }
}

//MARK: - UITableViewDataSource and UITableViewDelegate
extension PokemonListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseIdentifier) as? ListCell else { return UITableViewCell() }
        
        cell.setupInfos(with: viewModel.pokemons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTriggerAction(action: .didSelectPokemon(pokemonName: viewModel.pokemons[indexPath.row].name))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y <= 75 {
            tableViewTopAnchor?.constant = 75 - scrollView.contentOffset.y > 12 ? 75 - scrollView.contentOffset.y : 12
        } else if scrollView.contentOffset.y > 75 {
            tableViewTopAnchor?.constant = 12
        } else {
            tableViewTopAnchor?.constant = 75
        }
    }
}

//MARK: - PokemonGenerationPickerDelegate
extension PokemonListView: GenerationPickerDelegate {
    func didChangeGeneration(generation: String) {
        setupGenerationTitle(title: generation)
    }
    
    func didClosePickerView(generationIndex: Int) {
        delegate?.didTriggerAction(action: .didChangeGeneration(generationIndex: generationIndex))
    }
}
#endif
