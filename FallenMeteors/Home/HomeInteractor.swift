import Foundation

class HomeInteractor: HomeInteractorProtocol {
    
    weak var delegate: HomeInteractorDelegate!
    var entity: HomeEntityProtocol!
    var presenter: HomePresenterProtocol!
    
    var timer: Timer!
    
    deinit {
        print("HomeInteractor deinitialized")
    }
    
    func showMeteors() {
        
        guard let meteorsOrderedBySize = entity.meteorsOrderedBySize else {return}
        presenter.showMeteorData(meteorsOrderedBySize)
    }
    
    func beginBackendSyncHeartbeat() {
        timer = Timer()
        
        timer.oneHeartBeat = { [weak self] in
            guard let lastSync = self?.entity.lastBackendSync else { return }
            if(NSDate().timeIntervalSince(lastSync) >= 3.0) {
                self?.loadData()
            }
        }
    }
    
    private func loadData() {
        
        let request = NSMutableURLRequest(url: entity.url!)
        request.addValue("application/json", forHTTPHeaderField:"Accept")
        //TODO put this in enity
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

    private func parseJSON(data: Data){

        var jsonResult: Any!
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        } catch let error {
            print("Unable to parse Json. Error: \(error.localizedDescription)")
            return
        }
        
        guard var meteorData = jsonResult as? [[String: Any]] else { print("Unable to parse Json"); return }
        sortMeteorsBySize(&meteorData)
        storeMeteorData(meteorData)
        showMeteors()
        
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
    
    private func storeMeteorData(_ meteorsAsJson: [[String: Any]]) {
        
        var meteorsOrderedBySize = [MeteorData]()
        
        for meteorData in meteorsAsJson {
            
            guard let idAsString = meteorData["id"] as? String, let idAsInt = Int(idAsString) else {continue}
            
            var meteor = MeteorData()
            
            meteor.name = meteorData["name"] as? String
            meteor.mass = meteorData["mass"] as? String
            meteor.year = meteorData["year"] as? String
            
            if let coordinates = meteorData["coordinates"] as? [Double] {
                meteor.geoLocation = GeoLocation(latitude: coordinates[0], longitude: coordinates[1])
            }

            meteorsOrderedBySize.append(meteor)
            
        }
        

        entity.meteorsOrderedBySize = meteorsOrderedBySize
        entity.archive()
        
        updateTimeOfLastBackendSync()
    }
    
    private func updateTimeOfLastBackendSync() {
        let currentDate = Date()
        entity.lastBackendSync = currentDate
    }
    
}
extension HomeInteractor {
    func UIDidLoad() {
        showMeteors()
    }
}
