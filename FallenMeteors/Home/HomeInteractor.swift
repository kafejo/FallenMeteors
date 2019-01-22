import Foundation

class HomeInteractor: HomeInteractorProtocol {
    
    weak var delegate: HomeInteractorDelegate!
    var entity: HomeEntityProtocol!
    var presenter: HomePresenterProtocol!
    
    deinit {
        print("HomeInteractor deinitialized")
    }
    
    func loadData() {
        
        var urlRequest = URLRequest(url: entity.url!)
        
        urlRequest.setValue("limit", forHTTPHeaderField: "5000")
        urlRequest.setValue("yx6khWrHi7unQhXqp88y2GiaV", forHTTPHeaderField: "app_token")
 
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error ) in

            guard error == nil else {
                print(error?.localizedDescription ?? "An error occured when attemping to download meteor data");
                return
            }

            guard let data = data else {return}
            self?.parseJSON(data: data)

        }.resume()
        
    }

    private func parseJSON(data: Data){

        guard let MeteorData = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
            print("Not containing JSON")
            return
        }

        entity.meteors = MeteorData
    }
    
}
extension HomeInteractor {

}
