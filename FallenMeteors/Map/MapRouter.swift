import Foundation
import UIKit.UIViewController

class MapRouter: MapRouterProtocol {
    
    var interactor: MapInteractorProtocol!
    
    func assembleModule() -> UIViewController{
        let assembler = MapAssembler()
        
        self.interactor = assembler.interactor
        self.interactor.delegate = self
        
        let view = assembler.view
        
        return view as! UIViewController
    }

}
extension MapRouter {

}
