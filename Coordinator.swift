import UIKit

extension Coordinator: Equatable {
    static func ==(lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}

class Coordinator {
    
    var viewController: UIViewController!
    
    func start() {}
    
    var navigationItem: UINavigationItem { return viewController.navigationItem }
    var tabBarItem: UITabBarItem { return viewController.tabBarItem }
    
    // Presenting Coordinators
    func show(_ coordinator: Coordinator, sender: Any?) {
        viewController.show(coordinator.viewController, sender: sender)
        coordinator.parentCoordinator = self
    }
    func showDetailCoordinator(_ coordinator:Coordinator, sender: Any?) {
        viewController.showDetailViewController(coordinator.viewController, sender: sender)
        coordinator.parentCoordinator = self
    }
    func present(_ coordinatorToPresent: Coordinator, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewController.present(coordinatorToPresent.viewController, animated: flag, completion: completion)
        coordinatorToPresent.parentCoordinator = self
    }
    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        viewController.dismiss(animated: animated, completion: completion)
    }
    
    weak var parentCoordinator: Coordinator?
    var navigationCoordinator: NavigationCoordinator? {
        if let selfNav = self as? NavigationCoordinator {
            return selfNav
        } else {
            while let parent = parentCoordinator {
                if let parentNav = parent as? NavigationCoordinator {
                    return parentNav
                }
            }
        }
        return nil
    }
}


    
