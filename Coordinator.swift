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
    
    // UIViewController Navigation forwarding
    func show(_ coordinator: Coordinator, sender: Any?) {
        viewController.show(coordinator.viewController, sender: sender)
    }
    func showDetailCoordinator(_ coordinator:Coordinator, sender: Any?) {
        viewController.showDetailViewController(coordinator.viewController, sender: sender)
    }
    func present(_ coordinatorToPresent: Coordinator, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewController.present(coordinatorToPresent.viewController, animated: flag, completion: completion)
    }
}


    
