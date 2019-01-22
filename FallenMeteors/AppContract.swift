import Foundation
import UIKit.UIViewController

protocol AppMainUserInterfaceProtocol {
    var delegate: AppMainUserInterfaceDelegate! {get set}
    
    func presentViewController(_ viewController: UIViewController)
}

protocol AppMainUserInterfaceDelegate: class {
    func UserInterfaceDidLoad()
}
