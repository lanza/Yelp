import UIKit
import RxSwift

class FilterTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    let db = DisposeBag()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counts[section][expanded[section] ? 0 : 1]
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FilterCell(style: .default, reuseIdentifier: "cell")
        let (section,row) = (indexPath.section,indexPath.row)
        cell.textLabel?.text = (expanded[section] ? labels[section] : closedLabels[section])[row]
      
        var ctrl: FilterCell.Control
        
        
        var state: Bool? = nil
        
        if section == 0 {
            state = Filters.deals
            ctrl = .switch
        } else if section == 3 {
            if expanded[section] == false && row == 2 {
                ctrl = .dropDown
            } else {
                ctrl = .switch
            }
            state = Filters.categoryStates[row]
        } else if expanded[section] == false {
            ctrl = .dropDown
        } else {
            ctrl = .selector
        }
       
        if section == 1 {
            state = labels[section][row] == Filters.distance
        } else if section == 2 {
            state = labels[section][row] == Filters.sortBy
        }
        
        cell.setControl(ctrl, state: state)
       
        switch ctrl {
        case .dropDown:
            (cell.accessoryView as! UIButton).rx.tap.subscribe(onNext: {
                self.expanded[section] = true
                self.tableView.reloadData()
            }).addDisposableTo(db)
        default:
            print("hi")
        }
        
        return cell
    }
   
    var expanded = [false,false,false,false]
    let sectionTitles = [nil,"Distance","Sort By","Category"]
    let counts = [[1,1],[5,1],[3,1],[3,3]]
    let labels = [["Offering a Deal"],["0.5 Miles", "1 Mile", "5 Miles", "10 Miles", "25 Miles"], ["Best Match", "Distance", "Highest Rated"], ["Italian","Sushi","Vietnamese"]]
    var closedLabels: [[String]] { return [["Offering a Deal"],[Filters.distance],[Filters.sortBy],["Italian","Sushi","Show All"]] }
    
//    func switc

}

class FilterCell: UITableViewCell {
    enum Control {
        case `switch`
        case selector
        case dropDown
    }
    
    var control: Control!
    
    func setControl(_ control: Control, state: Bool?) {
        switch control {
        case .switch: setSwitch(state: state!)
        case .selector: setSelector(state: state!)
        case .dropDown: setDropDown()
        }
    }
    private func setSwitch(state: Bool) {
        let swtch = UISwitch()
        swtch.isOn = state
        contentView.addSubview(swtch)
        swtch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            swtch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            swtch.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor)
        ])
        
    }
    private func setSelector(state: Bool) {
        if state {
            accessoryType = .checkmark
        }
    }
    private func setDropDown() {
        let button = UIButton()
        button.setTitle("Dropdown", for: UIControlState())
        button.setTitleColor(.black, for: UIControlState())
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 35)
        accessoryView = button
    }
}


struct Filters {
    static var categoryNames = ["italian","sushi","vietnamese"]
    static var categoryStates = [true,true,true]
    static var sortBy = "Best Match"
    static var distance = "10 Miles"
    static var deals = false
}
