import Foundation
import UIKit.UIViewController

class HomeRouter: HomeRouterProtocol {
    var interactor: HomeInteractorProtocol!

    func assembleModule() -> UIViewController {
        let assembler = HomeAssembler()
        
        self.interactor = assembler.interactor
        
        let view = assembler.view
        
        //TODO rename to withbackend or something
        synchronize()
        
        return view as! UIViewController
    }
    
    func synchronize() {
        interactor.loadData()
    }
}
