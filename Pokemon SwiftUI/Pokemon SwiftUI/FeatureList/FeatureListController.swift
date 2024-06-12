//
//  FeatureListController.swift
//  Pokemon SwiftUI
//
//  Created by Scizor on 6/12/24.
//

import UIKit
import SwiftUI

class FeatureListController: UIViewController {
    
    private lazy var contentView: FeatureListView = {
        var view = FeatureListView()
        view.test = {
            print("ABDC")
        }
        return view
    }()
    private lazy var contentController = UIHostingController(rootView: contentView)

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(contentController)
        view.addSubview(contentController.view)
        setupConstraints()
        setupTitle("Feature List")
    }
    
    private func setupConstraints() {
        contentController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentController.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

