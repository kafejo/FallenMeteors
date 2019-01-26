import Foundation
import UIKit.UIViewController

class HomeRouter: HomeRouterProtocol {
    
    var interactor: HomeInteractorProtocol!
    var view: HomeViewProtocol!
    
    var mapRouter: MapRouter?

    func assembleModule() -> UIViewController {
        let assembler = HomeAssembler()
        
        interactor = assembler.interactor
        interactor.delegate = self
        
        let view = assembler.view
        self.view = view

        initialLaunchBackendSync()
        
        return view as! UIViewController
    }
    
    //TODO should this be here
    private func initialLaunchBackendSync() {
        
        interactor.beginBackendSyncHeartbeat()
        
        let firstLaunch = UserDefaults.standard.bool(forKey: "firstLaunch")
        guard !firstLaunch else {return}
        UserDefaults.standard.set(true, forKey: "firstLaunch")
        
        interactor.loadData()
    }
}
