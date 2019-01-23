import Foundation

class HomeInteractor: HomeInteractorProtocol {
    
    weak var delegate: HomeInteractorDelegate!
    var entity: HomeEntityProtocol!
    var presenter: HomePresenterProtocol!
    
    deinit {
        print("HomeInteractor deinitialized")
    }
    
    func loadData() {
        
        let request = NSMutableURLRequest(url: entity.url!)
        request.addValue("application/json", forHTTPHeaderField:"Accept")
        request.addValue("yx6khWrHi7unQhXqp88y2GiaV", forHTTPHeaderField: "X-App-Token")
 
        URLSession.shared.dataTask(with: request as URLRequest) { [weak self] (data, response, error ) in
            
            print("Getting Meteor data")

            guard error == nil else {
                print("An error occured while attemping to download meteor data \(error!.localizedDescription)");
                return
            }

            guard let data = data else {return}
            if let httpResponse = response as? HTTPURLResponse {
                print("Response Status Code: \(httpResponse.statusCode)")
            }
            
            self?.parseJSON(data: data)

        }.resume()
        
    }
    
    private func backendSyncHeartbeat() {
        //TODO check backend every x minues or on app wakeup
    }

    private func parseJSON(data: Data){

        var jsonResult: Any!
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        } catch let error {
            print("Unable to parse Json. Error: \(error.localizedDescription)")
            return
        }
        
        guard var meteorData = jsonResult as? [Dictionary<String, Any>] else { print("Unable to parse Json"); return }
        sortMeteorsBySize(&meteorData)
        entity.meteors = meteorData
        
        presenter.updateMeteorData(meteorData)
    }
    
    private func sortMeteorsBySize(_ meteorData: inout [[String: Any]]) {

        meteorData.sort{
            //TODO Double check
            guard let massOne = ($0["mass"] as? String) else { return false }
            guard let massTwo = ($1["mass"] as? String) else { return true }
            
            guard let massOneAsDouble = Double(massOne), let massTwoAsDouble = Double(massTwo) else {return false}
            
            return massOneAsDouble > massTwoAsDouble
        }
        
    }
}
extension HomeInteractor {

}
