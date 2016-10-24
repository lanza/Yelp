import UIKit

class YelpNavigationCoordinator: NavigationCoordinator {
    
    var mainCoordinator: MainCoordinator!
    
    override func start() {
        mainCoordinator = MainCoordinator()
        mainCoordinator.start()
        setCoordinators([mainCoordinator], animated: false)
    }
    
}

