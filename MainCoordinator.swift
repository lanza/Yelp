import UIKit

class MainCoordinator: Coordinator {
    
    var mainTVC: MainTVC { return viewController as! MainTVC }
    
    override init() {
        super.init()
        viewController = MainTVC(nibName: nil, bundle: nil)
        mainTVC.didTapFilter = { 
            let fc = FilterCoordinator()
            self.show(fc, sender: self)
        }
    }
    
}




