import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class FilterCoordinator: Coordinator {
    
    var filterTVC: FilterTVC { return viewController as! FilterTVC }
    
    override init() {
        super.init()
        viewController = FilterTVC(nibName: nil, bundle: nil)
        filterTVC.navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Search", style: .plain, target: nil, action: nil), UIBarButtonItem(title: "History", style: .plain, target: nil, action: nil)]
        filterTVC.navigationItem.rightBarButtonItems![0].rx.tap.subscribe(onNext: {
            self.didTapSearch()
        }).addDisposableTo(db)
        filterTVC.navigationItem.rightBarButtonItems![1].rx.tap.subscribe(onNext: {
            let hc = HistoryCoordinator()
            self.show(hc, sender: self)
        }).addDisposableTo(db)
    }
    let db = DisposeBag()
    var didTapSearch: (()->())!
    var didTapHistory: (()->())!
}

class HistoryCoordinator: Coordinator {
    var historyTVC: HistoryTVC { return viewController as! HistoryTVC }
    override init() {
        super.init()
        viewController = HistoryTVC(style: .plain)
    }
}

class HistoryTVC: UITableViewController {
    var filters: Results<Filter>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 45
        
        let realm = try! Realm()
        let result = realm.objects(Filter.self).sorted(byProperty: "date")
        filters = result
        tableView.reloadData()
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let filter = filters[indexPath.row]
        var string = "Categories: " + filter.categories
        string += ", Distance: " + String(filter.distance)
        string += ", Sorted by: " + filter.sortBy
        string += ", Deals: " + "\(filter.deals ? "On" : "Off")"
        cell.textLabel?.text = string
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
