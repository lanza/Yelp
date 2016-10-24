import UIKit
import RxSwift
import RxCocoa
import CoreLocation

class MainTVC: UITableViewController {
    
    let locationManager = CLLocationManager()
    let searchBar = UISearchBar()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        get()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupSearchBar()
        setupTableView()
        setupLocationManager()
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
            self.get()
            self.searchBar.resignFirstResponder()
        }).addDisposableTo(db)
    }
    func setupTableView() {
        tableView.register(YelpCell.self, forCellReuseIdentifier: "cell")
        businesses.asObservable().subscribe(onNext: { _ in
            self.tableView.reloadData()
        }).addDisposableTo(db)
    }
    func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func get() {
        guard let location = locationManager.location  else {
            let alert = UIAlertController(title: "Can't get location", message: "We can't find your location.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return
        }
        
        Yelper.shared.get(parameters: [:], location: location) { businesses in
            guard let businesses = businesses else { return }
            self.businesses.value = businesses
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


