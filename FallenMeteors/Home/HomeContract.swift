import Foundation
import UIKit

protocol HomeRouterProtocol: HomeInteractorDelegate {
    var interactor: HomeInteractorProtocol! {get set}
    
    func assembleModule() -> UIViewController
    func synchronize()
}

protocol HomeInteractorDelegate: class {
    
}

protocol HomeInteractorProtocol: HomePresenterDelegate {
    var delegate: HomeInteractorDelegate! {get set}
    var entity: HomeEntityProtocol! {get set}
    var presenter: HomePresenterProtocol! {get set}
    
    func loadData()
}

protocol HomePresenterDelegate: class {
}

protocol HomePresenterProtocol: HomeViewDelegate {
    var delegate: HomePresenterDelegate! {get set}
    var view: HomeViewProtocol! {get set}
    
    func updateMeteorData(_ meteorData: [Dictionary<String, Any>])

}

protocol HomeViewDelegate: class {

}

protocol HomeViewProtocol: class {
    var delegate: HomeViewDelegate! {get set}
    
    func showMeteorData(_ meteorData: [Dictionary<String, Any>])
}

protocol HomeEntityProtocol: class {
    var url: URL! {get set}
    var meteors: [Dictionary<String, Any>]? {get set}
}
