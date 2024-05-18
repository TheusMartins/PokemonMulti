//
//  BaseCoordinator.swift
//
//
//  Created by Scizor on 5/13/24.
//

#if canImport(UIKit)
import UIKit

public protocol AlertDelegate: AnyObject {
    func presentAlert(feedbackMessage: String, action: UIAlertAction)
}

open class BaseCoordinator: NSObject, Coordinator {
    public var children: [Coordinator] = []
    
    open var router: Router

    open func setupForPresentation() {
        router.setNavigation(delegate: self)
    }

    public init(router: Router = RouterImplementation()) {
        self.router = router
    }
}

extension BaseCoordinator: UINavigationControllerDelegate { }
#endif
