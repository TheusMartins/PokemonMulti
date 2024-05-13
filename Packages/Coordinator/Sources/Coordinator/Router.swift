//
//  Router.swift
//
//
//  Created by Scizor on 5/13/24.
//

import UIKit

public protocol BitsoRouterNavigator: UINavigationControllerDelegate {
    var navigationController: UINavigationController { get set }
    func setNavigation(delegate: UINavigationControllerDelegate)
}

public extension BitsoRouterNavigator {
    func setNavigation(delegate: UINavigationControllerDelegate) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.navigationController.delegate = delegate
        }
    }
}

/// Defines methods all concrete routers must implement, Specifically, it defines *present* and *dismiss* methods for showing and dismissing view controllers.
public protocol Router: BitsoRouterNavigator {
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
    func dismiss(animated: Bool, completion: (() -> Void)?)
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
    
    @discardableResult
    func popViewController(animated: Bool) -> UIViewController?
    
    @discardableResult
    func popToRootViewController(animated: Bool) -> [UIViewController]?
    
    func replaceLastViewController(with viewController: UIViewController, animated: Bool)

    /// Pops view controllers until the one specified is on top. Returns the popped controllers.
    @discardableResult
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]?
}

public extension Router {
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        navigationController.setViewControllers(viewControllers, animated: animated)
    }
    
    @discardableResult
    func popViewController(animated: Bool) -> UIViewController? {
        navigationController.popViewController(animated: animated)
    }
    
    @discardableResult
    func popToRootViewController(animated: Bool) -> [UIViewController]? {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func replaceLastViewController(with viewController: UIViewController, animated: Bool) {
        guard !navigationController.viewControllers.isEmpty else {
            return
        }
        var stack = navigationController.viewControllers
        stack[stack.endIndex - 1] = viewController
        navigationController.setViewControllers(stack, animated: animated)
    }

    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        navigationController.popToViewController(viewController, animated: animated)
    }
}

public extension Router {
    func present(_ viewController: UIViewController, animated: Bool) {
        present(viewController, animated: animated, completion: nil)
    }

    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewController(viewController, animated: animated, completion: nil)
    }

    func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
}
