import UIKit

class MainCoordinator: Coordinator {
    
    var mainTVC: MainTVC { return viewController as! MainTVC }
    
    override init() {
        super.init()
        viewController = MainTVC(nibName: nil, bundle: nil)
        mainTVC.didTapFilter = { [unowned self] in
            let fc = FilterCoordinator()
            fc.didTapSearch = { [unowned self] in
                _ = self.navigationCoordinator?.popCoordinator(animated: true)
                self.mainTVC.offset = 0
                self.mainTVC.get()
            }
            self.show(fc, sender: self)
        }
    }
}




