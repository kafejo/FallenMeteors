import Foundation
import UIKit.UIViewController

class AppMainViewController: UIViewController, AppMainUserInterfaceProtocol {
    
    weak var delegate: AppMainUserInterfaceDelegate!
    
    //Note: Call UserInterfaceDidLoad in **viewDidAppear**
    //to ensure the main VC is in the window hierarchy before Trying to push the map view
    override func viewDidAppear(_ animated: Bool) {
        delegate.UserInterfaceDidLoad()
    }
    
    func presentViewController(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
}

