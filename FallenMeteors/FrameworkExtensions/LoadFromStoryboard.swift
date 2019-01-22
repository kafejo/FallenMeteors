import UIKit.UIViewController

extension UIViewController {
    class func loadFromStoryboard<T: UIViewController>(_ storyboardName: String? = nil) -> T {
        let className = String(describing: T.self)
        let storyboard = UIStoryboard(name: storyboardName ?? className, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: className) as! T
        return viewController
    }
}
