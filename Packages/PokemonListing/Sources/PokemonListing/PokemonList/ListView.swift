//
//  ListView.swift
//
//
//  Created by Scizor on 5/8/24.
//

import UIKit
import DesignSystem

final class ListView: UIView {
    //MARK: - Private properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select generation"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    private let showPickerButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "iconArrowDown")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .BrandColors.pokeballRed
        return button
    }()
    
    private let spinnerLoader: SpinnerLoader = {
        let loader = SpinnerLoader()
        loader.color = .BrandColors.pokeballRed
        return loader
    }()
    
    //MARK: - Public properties
    var tableViewTopAnchor: NSLayoutConstraint?
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .BackgroundColors.backgroundColor
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let picker: GenerationPickerView
    
    //MARK: - Initialization
    init(
        dataSource: UITableViewDataSource,
        delegate: UITableViewDelegate,
        pokemonGenerationPickerDelegate: GenerationPickerDelegate
    ) {
        picker = GenerationPickerView(viewModel: <#[String]#>)
        super.init(frame: .zero)
        tableViewTopAnchor = tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func registerCells() {
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseIdentifier)
    }
    
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
        DispatchQueue.main.async { [weak self] in
            self?.spinnerLoader.isHidden = !isLoading
            self?.tableView.isHidden = isLoading
            isLoading ? self?.spinnerLoader.startAnimation() : self?.spinnerLoader.stopAnimating()
        }
    }
    
    func setupGenerationTitle(title: String) {
        titleLabel.text = title
    }
}

//MARK: - ViewConfiguration
extension ListView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [titleLabel, showPickerButton, tableView, spinnerLoader])
    }
    
    func setupConstraints() {
        guard let searchTextFieldTop = tableViewTopAnchor else { return }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            showPickerButton.heightAnchor.constraint(equalToConstant: 24),
            showPickerButton.widthAnchor.constraint(equalToConstant: 24),
            showPickerButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            showPickerButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12),
            
            searchTextFieldTop,
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            spinnerLoader.heightAnchor.constraint(equalToConstant: 52),
            spinnerLoader.widthAnchor.constraint(equalToConstant: 52),
            spinnerLoader.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            spinnerLoader.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func configureViews() {
        self.backgroundColor = .BackgroundColors.backgroundColor
        registerCells()
        setupshowPickerButton()
    }
}
