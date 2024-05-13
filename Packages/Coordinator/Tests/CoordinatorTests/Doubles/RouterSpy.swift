//
//  RouterSpy.swift
//
//
//  Created by Scizor on 5/13/24.
//

@testable import Coordinator
import UIKit

class RouterNavigatorSpy: NSObject, RouterNavigator {
    var invokedNavigationControllerSetter = false
    var invokedNavigationControllerSetterCount = 0
    var invokedNavigationController: UINavigationController?
    var invokedNavigationControllerList = [UINavigationController]()
    var invokedNavigationControllerGetter = false
    var invokedNavigationControllerGetterCount = 0
    var stubbedNavigationController: UINavigationController!

    var navigationController: UINavigationController {
        get {
            invokedNavigationControllerGetter = true
            invokedNavigationControllerGetterCount += 1
            return stubbedNavigationController
        }
        set {
            invokedNavigationControllerSetter = true
            invokedNavigationControllerSetterCount += 1
            invokedNavigationController = newValue
            invokedNavigationControllerList.append(newValue)
        }
    }

    var invokedSetNavigationDelegate = false
    var invokedSetNavigationDelegateCount = 0
    var invokedSetNavigationDelegateParameters: (delegate: UINavigationControllerDelegate, Void)?
    var invokedSetNavigationDelegateParametersList = [(delegate: UINavigationControllerDelegate, Void)]()

    func setNavigation(delegate: UINavigationControllerDelegate) {
        invokedSetNavigationDelegate = true
        invokedSetNavigationDelegateCount += 1
        invokedSetNavigationDelegateParameters = (delegate, ())
        invokedSetNavigationDelegateParametersList.append((delegate, ()))
    }
}

final class RouterSpy: RouterNavigatorSpy, Router {
    var invokedPresent = false
    var invokedPresentCount = 0
    var invokedPresentParameters: (viewController: UIViewController, animated: Bool, completion: (() -> Void)?)?
    var invokedPresentParametersList = [(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)]()

    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        invokedPresent = true
        invokedPresentCount += 1
        invokedPresentParameters = (viewController, animated, completion)
        invokedPresentParametersList.append((viewController, animated, completion))
    }

    var invokedPushViewController = false
    var invokedPushViewControllerCount = 0
    var invokedPushViewControllerParameters: (viewController: UIViewController, animated: Bool, completion: (() -> Void)?)?
    var invokedPushViewControllerParametersList = [(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)]()

    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        invokedPushViewController = true
        invokedPushViewControllerCount += 1
        invokedPushViewControllerParameters = (viewController, animated, completion)
        invokedPushViewControllerParametersList.append((viewController, animated, completion))
    }

    var invokedDismiss = false
    var invokedDismissCount = 0
    var invokedDismissParameters: (animated: Bool, completion: (() -> Void)?)?
    var invokedDismissParametersList = [(animated: Bool, completion: (() -> Void)?)]()

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        invokedDismiss = true
        invokedDismissCount += 1
        invokedDismissParameters = (animated, completion)
        invokedDismissParametersList.append((animated, completion))
    }

    var invokedSetViewControllers = false
    var invokedSetViewControllersCount = 0
    var invokedSetViewControllersParameters: (viewControllers: [UIViewController], animated: Bool)?
    var invokedSetViewControllersParametersList = [(viewControllers: [UIViewController], animated: Bool)]()

    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        invokedSetViewControllers = true
        invokedSetViewControllersCount += 1
        invokedSetViewControllersParameters = (viewControllers, animated)
        invokedSetViewControllersParametersList.append((viewControllers, animated))
    }

    var invokedPopViewController = false
    var invokedPopViewControllerCount = 0
    var invokedPopViewControllerParameters = Bool()
    var invokedPopViewControllerParametersList = [Bool]()
    var stubbedPopViewControllerResult: UIViewController?

    func popViewController(animated: Bool) -> UIViewController? {
        invokedPopViewController = true
        invokedPopViewControllerCount += 1
        invokedPopViewControllerParameters = animated
        invokedPopViewControllerParametersList.append(animated)
        return stubbedPopViewControllerResult
    }

    var invokedPopToRootViewController = false
    var invokedPopToRootViewControllerCount = 0
    var invokedPopToRootViewControllerParameters = Bool()
    var invokedPopToRootViewControllerParametersList = [Bool]()
    var stubbedPopToRootViewControllerResult: [UIViewController]?

    func popToRootViewController(animated: Bool) -> [UIViewController]? {
        invokedPopToRootViewController = true
        invokedPopToRootViewControllerCount += 1
        invokedPopToRootViewControllerParameters = animated
        invokedPopToRootViewControllerParametersList.append(animated)
        return stubbedPopToRootViewControllerResult
    }

    var invokedReplaceLastViewController = false
    var invokedReplaceLastViewControllerCount = 0
    var invokedReplaceLastViewControllerParameters: (viewController: UIViewController, animated: Bool)?
    var invokedReplaceLastViewControllerParametersList = [(viewController: UIViewController, animated: Bool)]()

    func replaceLastViewController(with viewController: UIViewController, animated: Bool) {
        invokedReplaceLastViewController = true
        invokedReplaceLastViewControllerCount += 1
        invokedReplaceLastViewControllerParameters = (viewController, animated)
        invokedReplaceLastViewControllerParametersList.append((viewController, animated))
    }

    var invokedPopToViewController = false
    var invokedPopToViewControllerCount = 0
    var invokedPopToViewControllerParameters: (viewController: UIViewController, animated: Bool)?
    var invokedPopToViewControllerParametersList = [(viewController: UIViewController, animated: Bool)]()
    var stubbedPopToViewControllerResult: [UIViewController]?

    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        invokedPopToViewController = true
        invokedPopToViewControllerCount += 1
        invokedPopToViewControllerParameters = (viewController, animated)
        invokedPopToViewControllerParametersList.append((viewController, animated))
        return stubbedPopToViewControllerResult
    }
}

