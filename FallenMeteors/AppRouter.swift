import Foundation
import UIKit.UIViewController

class AppRouter: AppMainUserInterfaceDelegate {

    //Maybe don't need this stored here as this lets try a UIViewController
    var appMainViewController: AppMainUserInterfaceProtocol!
    var homeRouter: HomeRouterProtocol!
    
    init(with appMainViewController: AppMainUserInterfaceProtocol) {
        self.appMainViewController = appMainViewController
        self.appMainViewController.delegate = self
    }
    
    private func setupApp() {
        homeRouter = HomeRouter()
        
        let homeView = homeRouter.assembleModule()
        appMainViewController.presentViewController(homeView)
    }
}

extension AppRouter {
    func UserInterfaceDidLoad() {
        setupApp()
    }
}
