import Foundation
import UIKit

class HomePresenter: HomePresenterProtocol {
    
    weak var delegate: HomePresenterDelegate!
    var view: HomeViewProtocol!
    
    func showMeteorData(_ meteorData: [MeteorData]) {
        view.showMeteorData(meteorData)
    }

}
extension HomePresenter {
    func viewDidLoad() {
        delegate.UIDidLoad()
    }
}
