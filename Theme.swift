import UIKit

struct Theme {
    static func `do`() {
        let na = UINavigationBar.appearance()
        na.barStyle = .black
        na.backgroundColor = Colors.red
        na.tintColor = Colors.tint
    }
}

struct Colors {
    static let red = UIColor.red
    static let tint = UIColor.lightGray
}
