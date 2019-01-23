import Foundation
import UIKit

class HomePresenter: HomePresenterProtocol {
    
    weak var delegate: HomePresenterDelegate!
    var view: HomeViewProtocol!
    
    func updateMeteorData(_ meteorData: [Dictionary<String, Any>]) {
        view.showMeteorData(meteorData)
    }
}
extension HomePresenter {
    
}
