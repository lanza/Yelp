import UIKit

class YelpCoordinator: NavigationCoordinator {
    
    var mainCoordinator: MainCoordinator!
    
    override func start() {
        Theme.do()
        mainCoordinator = MainCoordinator()
        mainCoordinator.start()
        setCoordinators([mainCoordinator], animated: false)
    }
    
    
}


