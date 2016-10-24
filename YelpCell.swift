import UIKit

class YelpCell: UITableViewCell {
    func configure(for business: Business) {
        textLabel?.text = business.name
    }
}
