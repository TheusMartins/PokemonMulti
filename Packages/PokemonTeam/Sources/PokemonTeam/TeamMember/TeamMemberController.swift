//
//  TeamMemberController.swift
//
//
//  Created by Scizor on 5/6/24.
//

import UIKit

final class TeamMemberController: UIViewController {
    //MARK: - Private properties
    private lazy var customView: TeamMemberView = {
        let customView = TeamMemberView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    private let viewModel: TeamMemberViewModel
    
    //MARK: - Overrides
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Initialization
    init(viewModel: TeamMemberViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    @objc private func removePokemonFromTeam() {

    }
    
    @objc private func showFeedbackModal() {

    }
}
