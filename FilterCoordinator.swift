import UIKit

class FilterCoordinator: Coordinator {
    
    var filterTVC: FilterTVC { return viewController as! FilterTVC }
    
    override init() {
        super.init()
        viewController = FilterTVC(nibName: nil, bundle: nil)
    }
}
