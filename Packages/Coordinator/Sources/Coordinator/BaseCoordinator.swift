//
//  BaseCoordinator.swift
//
//
//  Created by Scizor on 5/13/24.
//

import UIKit

public protocol AlertDelegate: AnyObject {
    func presentAlert(feedbackMessage: String, action: UIAlertAction)
}

open class BaseCoordinator: NSObject, Coordinator {
    open var router: Router

    open func setupForPresentation() {
        router.setNavigation(delegate: self)
    }

    public init(router: Router = RouterImplementation()) {
        self.router = router
    }
}

extension BaseCoordinator: UINavigationControllerDelegate { }

