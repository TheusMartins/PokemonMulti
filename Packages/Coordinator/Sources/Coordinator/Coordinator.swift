//
//  Coordinator.swift
//
//
//  Created by Scizor on 5/13/24.
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    /// Needed to keep reference on presented flows
    var children: [Coordinator] { get set }
    
    /// Property responsible to handle the rounting/ navigation in the app
    var router: Router { get }
    
    /// The start method, whenever using a coordinator we need to call this method in order to show a view controller.
    func setupForPresentation()
    
    /// Internally it calls the router dismiss, each router will have different ways to dismiss.
    /// - Parameter animated: if the router will dismiss animating or not.
    /// - Parameter completion: The block to execute after the view controller is dismissed. This block has no return value and takes no parameters.
    /// You may specify nil for this parameter.
    func dismiss(
        animated: Bool,
        completion: (() -> Void)?
    )

    /// Presents the desired coordinator over the current one with a defined strategy.
    ///
    ///   This method **MUST** be called with all of its parameters in order to use Swift's dynamic dispatch during the test suite execution.
    ///   This allows replacement during runtime (useful for spying inside concrete implementations with BitsoCore's `BitsoCoordinatorSpy`)
    /// - Parameters:
    ///   - child: `Coordinator` to be presented
    ///   - animated: animation flag for presentation
    ///   - onDismissed: closure action to be executed on Coordinator's dismissal
    func presentChild(
        _ child: Coordinator,
        animated: Bool,
        onDismissed: (() -> Void)?
    )
}

public extension Coordinator {
    func dismiss(
        animated: Bool,
        completion: (() -> Void)?
    ) {
        router.dismiss(animated: animated, completion: completion)
    }
    
    func presentChild(
        _ child: Coordinator,
        animated: Bool,
        onDismissed: (() -> Void)?
    ) {
        children.append(child)
        child.setupForPresentation()
        router.present(child.router.navigationController, animated: animated, completion: nil)
    }
}

