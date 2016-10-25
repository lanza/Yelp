import UIKit

class NavigationCoordinator: Coordinator {
    
    private var navigationController: UINavigationController! { return viewController as! UINavigationController }
    
    override init() {
        super.init()
        self.viewController = UINavigationController()
    }
    
    override func start() {
        super.start()
        interactivePopGestureRecognizer?.addTarget(self, action: #selector(NavigationCoordinator.popGestureRecognized(_:)))
    }
    
    //Implementation
    @objc private func popGestureRecognized(_ gr: UIGestureRecognizer) {
        _ = popCoordinator(animated: true)
    }
    
    //Accessing Items on the Navigation Stack - Coordinators
    var topCoordinator: Coordinator? { return coordinators.first }
    var visibleCoordinator: Coordinator? { return coordinators.last }
    var coordinators = [Coordinator]()
    func setCoordinators(_ coordinators: [Coordinator], animated: Bool) {
        for i in 1..<(coordinators.count) {
            coordinators[i].parentCoordinator = coordinators[i-1]
        }
        if let first = coordinators.first {
            first.parentCoordinator = self
        }
        let vcs = coordinators.map { $0.viewController! }
        navigationController.setViewControllers(vcs, animated: animated)
    }
    
    // Pushing and Popping Stack Items
    func pushCoordinator(_ coordinator: Coordinator, animated: Bool) {
        coordinator.parentCoordinator = coordinators.last
        navigationController.pushViewController(coordinator.viewController, animated: true)
    }
    func popCoordinator(animated: Bool) -> Coordinator? {
        navigationController.popViewController(animated: true)
        return coordinators.popLast()
    }
    func popToRootCoordinator(animated: Bool) -> [Coordinator]? {
        _ = navigationController.popToRootViewController(animated: animated)
        let last = Array(coordinators.suffix(from: 1))
        coordinators = [coordinators[0]]
        return last
    }
    func popToCoordinator(_ coordinator: Coordinator, animated: Bool) -> [Coordinator]? {
        guard let index = coordinators.index(of: coordinator) else { return nil }
        let removed = Array(coordinators.suffix(from: index))
        coordinators = Array(coordinators.prefix(upTo: index))
        return removed
    }
    var interactivePopGestureRecognizer: UIGestureRecognizer? {
        let gr = navigationController.interactivePopGestureRecognizer
        return gr
    }
    
}
