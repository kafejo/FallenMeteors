import Foundation
import UIKit.UIViewController

typealias mapCompletionHandler = () -> Void

class MapRouter: MapRouterProtocol {
    
    var interactor: MapInteractorProtocol!
    var completionHandler: mapCompletionHandler!
    
    func assembleModule() -> UIViewController{
        let assembler = MapAssembler()
        
        self.interactor = assembler.interactor
        self.interactor.delegate = self
        
        let view = assembler.view
        
        return view as! UIViewController
    }
    
    func showMeteorOnMap(meteor: MeteorData , completionHandler: @escaping mapCompletionHandler) {
        self.completionHandler = completionHandler
        interactor.showMeteor(meteor)
    }
    
    private func dismiss() {
        completionHandler()
    }

}
extension MapRouter {
    func didFinishShowingMeteor() {
        dismiss()
    }
}
