//
//  RouterImplementation.swift
//
//
//  Created by Scizor on 5/13/24.
//

import UIKit

public final class RouterImplementation: NSObject, Router {
    public var navigationController: UINavigationController
    
    public init(
        navigationController: UINavigationController = UINavigationController(),
        modalPresentationStyle: UIModalPresentationStyle = .formSheet,
        isNavigationBarHidden: Bool = false
    ) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.modalPresentationStyle = modalPresentationStyle
        self.navigationController.presentationController?.delegate = self
        self.navigationController.isNavigationBarHidden = isNavigationBarHidden
    }
}

extension RouterImplementation: UIAdaptivePresentationControllerDelegate { }
