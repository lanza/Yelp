import UIKit
import RxSwift
import JTMaterialSwitch

class FilterTVC: UITableViewController {
    let db = DisposeBag()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Filters.history()
    }
    
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
        case .selector:
            (cell.accessoryView as! UIButton).rx.tap.subscribe(onNext: { [unowned self] in
                switch section {
                case 1:
                    Filters.distance = self.labels[1][row]
                case 2:
                    Filters.sortBy = self.labels[2][row]
                default: fatalError()
                }
                self.expanded[section] = false
                self.tableView.reloadData()
            }).addDisposableTo(db)
        case .switch:
            let swtch = (cell.accessoryView as! JTMaterialSwitch)
            swtch.rx.controlEvent(.valueChanged).subscribe(onNext: {
                switch section {
                case 0:
                    Filters.deals = swtch.isOn
                case 3:
                    Filters.categoryStates[row] = swtch.isOn
                default: fatalError()
                }
            }).addDisposableTo(db)
        }
        
        cell.selectionStyle = .none
        return cell
    }
   
    var expanded = [false,false,false,false]
    let sectionTitles = [nil,"Distance","Sort By","Category"]
    let counts = [[1,1],[5,1],[3,1],[3,3]]
    let labels = [["Offering a Deal"],["0.5 Miles", "1 Mile", "5 Miles", "10 Miles", "25 Miles"], ["Best Match", "Distance", "Rating"], ["Italian","Sushi","Vietnamese"]]
    var closedLabels: [[String]] { return [["Offering a Deal"],[Filters.distance],[Filters.sortBy],["Italian","Sushi","Show All"]] }
}





