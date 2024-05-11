//
//  TeamMemberController.swift
//
//
//  Created by Scizor on 5/6/24.
//

import UIKit

protocol TeamMemberControllerDelegate: AnyObject {
    func didDeletePokemon()
}

final class TeamMemberController: UIViewController {
    // MARK: - Open properties
    
    weak var delegate: TeamMemberControllerDelegate?
    
    // MARK: - Private properties
    
    private lazy var customView: TeamMemberView = {
        let customView = TeamMemberView()
        customView.delegate = self
        return customView
    }()
    
    private let viewModel: TeamMemberViewModel
    
    // MARK: - Overrides
    
    override func loadView() {
        super.loadView()
        view = customView
        customView.delegate = self
        viewModel.delegate = self
        Task { viewModel.laodPokemon() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Initialization
    
    init(viewModel: TeamMemberViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func showFeedbackModal(feedbackMessage: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let alert = UIAlertController(title: feedbackMessage, message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateLocalPokemons"), object: nil)
            }
            alert.addAction(alertAction)
            navigationController?.present(alert, animated: true, completion: nil)
        }
    }
}

extension TeamMemberController: TeamMemberViewDelegate {
    func didTrigger(action: TeamMemberView.Actions) {
        switch action {
        case .didTapOnDelete: Task { await viewModel.removePokemonFromTeam() }
        }
    }
}

extension TeamMemberController: TeamMemberViewModelDelegate {
    func stateDidChange(state: TeamMemberViewModel.State) {
        switch state {
        case .didLoadTeamMember(let pokemons):
            customView.setupInfos(with: pokemons)
        case .didDeleteTeamMember(let feedbackMessage), .couldNotDeleteTeamMember(let feedbackMessage):
            showFeedbackModal(feedbackMessage: feedbackMessage)
            delegate?.didDeletePokemon()
        }
    }
}
