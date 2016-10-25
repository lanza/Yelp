import UIKit
import JTMaterialSwitch

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
        let swtch = JTMaterialSwitch()
        swtch?.isOn = state
        swtch?.sizeToFit()
        accessoryView = swtch
    }
    private func setSelector(state: Bool) {
        let button = UIButton()
        button.setTitle(state ? "On" : "Off", for: UIControlState())
        button.setTitleColor(.black, for: UIControlState())
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 35)
        accessoryView = button
    }
    private func setDropDown() {
        let button = UIButton()
        button.setTitle("Dropdown", for: UIControlState())
        button.setTitleColor(.black, for: UIControlState())
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 35)
        accessoryView = button
    }
}
