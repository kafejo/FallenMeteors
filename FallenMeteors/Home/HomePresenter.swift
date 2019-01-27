class HomePresenter: HomePresenterProtocol {
    
    weak var delegate: HomePresenterDelegate!
    var view: HomeViewProtocol!
    
   func showMeteorData(meteorsOrderedByMass: [MeteorData], meteorsWithoutMass: [MeteorData]) {
        view.showMeteorData(meteorsOrderedByMass: meteorsOrderedByMass, meteorsWithoutMass: meteorsWithoutMass)
    }

}
extension HomePresenter {
    func viewDidLoad() {
        delegate.UIDidLoad()
    }
    
    func didSelectMeteor(meteor: MeteorData) {
        delegate.didSelectMeteor(meteor: meteor)
    }
}
