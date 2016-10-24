import Foundation
import SwiftyJSON

struct Business {
    let categories: [String]
    let imageURL: String
    let address: String
    let city: String
    let name: String
    let phone: String
    let rating: String
    
    static func parse(data: Any) -> [Business] {
        return JSON(data)["businesses"].arrayValue.map { Business(json: $0) }
    }
    init(json: JSON) {
        self.categories = json["categories"].arrayValue.map { $0.dictionaryObject!["title"] as! String }
        self.imageURL = json["image_url"].stringValue
        let location = json["location"].dictionaryValue
        self.address = location["address1"]!.stringValue
        self.city = location["city"]!.stringValue
        self.name = json["name"].stringValue
        self.phone = json["phone"].stringValue
        self.rating = json["rating"].stringValue
    }
}
