import Foundation
import UIKit.UIViewController

struct HomeAssembler {

    let view: HomeViewProtocol
    let entity: HomeEntityProtocol
    let presenter: HomePresenterProtocol
    let interactor: HomeInteractorProtocol
    
    init(entity: HomeEntityProtocol = HomeEntity() ,presenter: HomePresenterProtocol = HomePresenter(), interactor: HomeInteractorProtocol = HomeInteractor()) {
        
        let view: HomeView = UIViewController.loadFromStoryboard()
        
        self.view = view
        self.entity = entity
        self.presenter = presenter
        self.interactor = interactor
        
        assemble()
    }
    
    func assemble() {
        view.delegate = presenter
        presenter.delegate = interactor
        interactor.entity = entity
        interactor.presenter = presenter
        presenter.view = view
        
        entity.url = URL(string: "https://data.nasa.gov/resource/y77d-th95.json")
    
    }
    
}
