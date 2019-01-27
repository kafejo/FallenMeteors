import Foundation
import UIKit.UIViewController

class AppRouter: AppMainUserInterfaceDelegate {

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
