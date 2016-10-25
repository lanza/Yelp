import UIKit
import AlamofireImage

class YelpCell: UITableViewCell {
    func configure(for business: Business) {
        pictureImageView.af_setImage(withURL: URL(string: business.imageURL)!)
        nameLabel.text = business.name
        reviewCountLabel.text = business.rating
        distanceLabel.text = business.dollars
        addressLabel.text = business.address + ", " + business.city
        categoriesLabel.text = business.categories.joined(separator: ", ")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    func setupViews() {
        var constraints = [NSLayoutConstraint]()
        
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
        }
        
        pictureImageView.setContentCompressionResistancePriority(0, for: .vertical)
        pictureImageView.setContentHuggingPriority(1000, for: .vertical)
        constraints.append(pictureImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25))
        constraints.append(pictureImageView.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor))
        constraints.append(pictureImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor))
        constraints.append(pictureImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor))
        constraints.append(nameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor))
        constraints.append(nameLabel.leftAnchor.constraint(equalTo: pictureImageView.rightAnchor, constant: 8))
        constraints.append(addressLabel.topAnchor.constraint(equalTo: reviewCountLabel.bottomAnchor, constant: 8))
        constraints.append(addressLabel.leftAnchor.constraint(equalTo: pictureImageView.rightAnchor, constant: 8))
        constraints.append(addressLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor))
        addressLabel.setContentCompressionResistancePriority(500, for: .horizontal)
        constraints.append(categoriesLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8))
        constraints.append(categoriesLabel.leftAnchor.constraint(equalTo: pictureImageView.rightAnchor, constant: 8))
        constraints.append(categoriesLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor))
        constraints.append(categoriesLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor))
        categoriesLabel.setContentCompressionResistancePriority(500, for: .horizontal)
        constraints.append(distanceLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor))
        constraints.append(distanceLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor))
        constraints.append(distanceLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 8))
        nameLabel.setContentCompressionResistancePriority(500, for: .horizontal)
        constraints.append(reviewCountLabel.leftAnchor.constraint(equalTo: pictureImageView.rightAnchor, constant: 8))
        constraints.append(reviewCountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    let pictureImageView = UIImageView()
    let nameLabel = UILabel()
    let reviewCountLabel = UILabel()
    let distanceLabel = UILabel()
    let addressLabel = UILabel()
    let categoriesLabel = UILabel()
    var views: [UIView] { return [pictureImageView, nameLabel,reviewCountLabel,distanceLabel,addressLabel,categoriesLabel] }
    
}
