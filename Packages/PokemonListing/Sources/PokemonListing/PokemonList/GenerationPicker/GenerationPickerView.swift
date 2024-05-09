//
//  GenerationPickerView.swift
//
//
//  Created by Scizor on 5/8/24.
//

import UIKit
import DesignSystem

protocol GenerationPickerDelegate: AnyObject {
    func didClosePickerView(generationIndex: Int)
    func didChangeGeneration(generation: String)
}

final class GenerationPickerView: UIView {
    // MARK: - Open properties
    var viewModel: [String]
    
    // MARK: - Private properties
    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    private var generationIndex = 0
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.BrandColors.pokeballRed, for: .normal)
        return button
    }()
    
    weak var delegate: GenerationPickerDelegate?
    
    //MARK: - Initialization
    init(viewModel: [String]) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    @objc private func closePickerView() {
        delegate?.didClosePickerView(generationIndex: generationIndex)
        delegate?.didChangeGeneration(generation: viewModel[generationIndex])
        removeFromSuperview()
    }
}

// MARK: - ViewConfiguration
extension GenerationPickerView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews(views: [picker, closeButton])
        bringSubviewToFront(closeButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: .Measure.measure12),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.Measure.measure12),
            closeButton.heightAnchor.constraint(equalToConstant: .Measure.measure48),
            closeButton.widthAnchor.constraint(equalToConstant: .Measure.measure48),
            
            picker.topAnchor.constraint(equalTo: topAnchor, constant: .Measure.measure12),
            picker.leadingAnchor.constraint(equalTo: leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: bottomAnchor),
            picker.heightAnchor.constraint(equalToConstant: .pickerHeight)
        ])
    }
    
    func configureViews() {
        backgroundColor = .white
        closeButton.addTarget(self, action: #selector(closePickerView), for: .touchUpInside)
    }
}

// MARK: - UIPickerViewDataSource
extension GenerationPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.count
    }
}

// MARK: - UIPickerViewDelegate
extension GenerationPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        generationIndex = row
    }
}

private extension CGFloat {
    static var pickerHeight: CGFloat {
        150
    }
}
