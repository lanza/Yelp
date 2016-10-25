import UIKit
import RxSwift
import RxCocoa
import CoreLocation

extension MainTVC {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !moreDataIsLoading {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.height
            
            if scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging {
                moreDataIsLoading = true
                get()
            }
        }
    }
}

class MainTVC: UITableViewController {
    
    var moreDataIsLoading = false
    
    let locationManager = CLLocationManager()
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupSearchBar()
        setupTableView()
        setupLocationManager()
        
        offset = 0
        get()
    }
    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.rx.tap.subscribe(onNext: {
            self.didTapFilter()
        }).addDisposableTo(db)
    }
    func setupSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.rx.searchButtonClicked.subscribe(onNext: {
            self.offset = 0
            self.get()
            self.searchBar.resignFirstResponder()
        }).addDisposableTo(db)
    }
    func setupTableView() {
        tableView.register(YelpCell.self, forCellReuseIdentifier: "cell")
        businesses.asObservable().subscribe(onNext: { _ in
            self.tableView.reloadData()
        }).addDisposableTo(db)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
    }
    func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
    }
    var offset: Int! {
        didSet {
            if offset == 0 {
                self.businesses.value = []
            }
        }
    }
    
    func get() {
        guard let location = locationManager.location  else {
            let alert = UIAlertController(title: "Can't get location", message: "We can't find your location.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return
        }
       
        guard let term = searchBar.text else { return }
        moreDataIsLoading = true
        Yelper.shared.get(parameters: Filters.params(with: term), offset: offset, location: location) { businesses in
            guard let businesses = businesses else { return }
            self.businesses.value += businesses
            self.offset! += businesses.count
            self.moreDataIsLoading = false
        }
    }
    
    var businesses = Variable([Business]())

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.value.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! YelpCell
        cell.configure(for: businesses.value[indexPath.row])
        return cell
    }
    
    var didTapFilter: (() -> ())!
    
    let db = DisposeBag()
}


