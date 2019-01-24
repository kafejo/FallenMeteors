import Foundation
import UIKit.UIViewController

class HomeRouter: HomeRouterProtocol {
    var interactor: HomeInteractorProtocol!

    func assembleModule() -> UIViewController {
        let assembler = HomeAssembler()
        
        self.interactor = assembler.interactor
        
        let view = assembler.view

        initialLaunchBackendSync()
        
        return view as! UIViewController
    }
    
    private func initialLaunchBackendSync() {
        
        //TODO is this the best place to put something like this or no 
        let firstLaunch = UserDefaults.standard.bool(forKey: "firstLaunch")
        guard !firstLaunch else {return}
        UserDefaults.standard.set(true, forKey: "firstLaunch")
        
        interactor.loadData()
    }
}
