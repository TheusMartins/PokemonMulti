@testable import Coordinator
import UIKit
import XCTest

final class BaseCoordinatorTests: XCTestCase {
    var routerSpy: RouterSpy!
    var baseCoordinator: BaseCoordinator!

    override func setUp() {
        super.setUp()
        routerSpy = RouterSpy()
        baseCoordinator = BaseCoordinator(router: routerSpy)
    }

    override func tearDown() {
        routerSpy = nil
        baseCoordinator = nil
        super.tearDown()
    }

    func testSetupForPresentationSetsNavigationDelegate() {
        // Given

        // When
        baseCoordinator.setupForPresentation()

        // Then
        XCTAssertTrue(routerSpy.invokedSetNavigationDelegate)
        XCTAssertEqual(routerSpy.invokedSetNavigationDelegateParameters?.delegate as? BaseCoordinator, baseCoordinator)
    }

    func testPresentViewController() {
        // Given
        let viewControllerToPresent = UIViewController()

        // When
        baseCoordinator.router.present(viewControllerToPresent, animated: true)

        // Then
        XCTAssertTrue(routerSpy.invokedPresent)
        XCTAssertEqual(routerSpy.invokedPresentParameters?.viewController, viewControllerToPresent)
        XCTAssertTrue(routerSpy.invokedPresentParameters?.animated ?? false)
    }

    func testPushViewController() {
        // Given
        let viewControllerToPush = UIViewController()

        // When
        baseCoordinator.router.pushViewController(viewControllerToPush, animated: true)

        // Then
        XCTAssertTrue(routerSpy.invokedPushViewController)
        XCTAssertEqual(routerSpy.invokedPushViewControllerParameters?.viewController, viewControllerToPush)
        XCTAssertTrue(routerSpy.invokedPushViewControllerParameters?.animated ?? false)
    }

    func testDismissViewController() {
        // Given

        // When
        baseCoordinator.router.dismiss(animated: true)

        // Then: The Router should be asked to dismiss the view controller
        XCTAssertTrue(routerSpy.invokedDismiss)
        XCTAssertTrue(routerSpy.invokedDismissParameters?.animated ?? false)
    }

    func testSetViewControllers() {
        // Given
        let viewControllers = [UIViewController(), UIViewController()]

        // When
        baseCoordinator.router.setViewControllers(viewControllers, animated: true)

        // Then
        XCTAssertTrue(routerSpy.invokedSetViewControllers)
        XCTAssertEqual(routerSpy.invokedSetViewControllersParameters?.viewControllers, viewControllers)
        XCTAssertTrue(routerSpy.invokedSetViewControllersParameters?.animated ?? false)
    }
}
