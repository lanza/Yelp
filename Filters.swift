import Foundation
import RealmSwift

struct Filters {
    static var categoryNames = ["italian","sushi","vietnamese"]
    static var categoryStates = [true,true,true]
    private static var categoriesString: String {
        return zip(categoryNames, categoryStates).flatMap { term, isOn in isOn ? term : nil }.joined(separator: ",")
    }
    static var sortBy = "Best Match"
    static var sort_by: String {
        return sortBy.lowercased().replacingOccurrences(of: " ", with: "_")
    }
    static var distance = "10 Miles"
    private static var distanceInt: Int {
        let milesInt = Int(distance.trimmingCharacters(in: .letters).trimmingCharacters(in: .whitespaces))!
        return Int(Measurement<UnitLength>(value: Double(milesInt), unit: .miles).converted(to: .meters).value)
    }
    static var deals = false
    
    static func params(with term: String) -> [String:Any] {
        return ["term":term,"categories":categoriesString,"sort_by":sort_by,"radius":String(distanceInt),"attributes":(deals ? "deals" : "")]
    }
    
    static func history() {
        let history = Filter()
        history.categories = categoriesString
        history.sortBy = sort_by
        history.distance = distanceInt
        history.deals = deals
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(history)
        }
    }
}

class Filter: Object {
    dynamic var categories = ""
    dynamic var sortBy = ""
    dynamic var distance = 0
    dynamic var deals = false
    dynamic var date = Date()
    override static func indexedProperties() -> [String] { return ["date"] }
}
