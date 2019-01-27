import Foundation

class HomeInteractor: HomeInteractorProtocol {
    
    weak var delegate: HomeInteractorDelegate!
    var entity: HomeEntityProtocol!
    var presenter: HomePresenterProtocol!
    
    var timer: Timer!
    var dataRequestHandler: MeteorDataRequestHandler!
    
    deinit {
        print("HomeInteractor deinitialized")
    }
    
    func showMeteors() {
        
        guard let meteorsOrderedByMass = entity.meteorsOrderedByMass, let meteorsWithoutMass = entity.meteorsWithoutMass else {return}
        
        presenter.showMeteorData(meteorsOrderedByMass: meteorsOrderedByMass, meteorsWithoutMass: meteorsWithoutMass)
    }
    
    func beginBackendSyncHeartbeat() {
        timer = Timer()
        
        //TODO make a constant
        timer.oneHeartBeat = { [weak self] in
            guard let lastSync = self?.entity.lastBackendSync else { return }
            if(NSDate().timeIntervalSince(lastSync) >= 60.0) {
                self?.loadData()
            }
        }
    }

    func loadData() {
        dataRequestHandler = MeteorDataRequestHandler()
        dataRequestHandler.loadData() { [weak self] (result) in
            self?.parseJSON(data: result)
        }
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
        sortMeteorsByMass(&meteorData)
        storeMeteorDataInCorrectFormat(meteorData)
        showMeteors()
        
    }
    
    private func sortMeteorsByMass(_ meteorData: inout [[String: Any]]) {

        meteorData.sort{
            //TODO Double check
            guard let massOne = ($0["mass"] as? String) else { return false }
            guard let massTwo = ($1["mass"] as? String) else { return true }
            
            guard let massOneAsDouble = Double(massOne), let massTwoAsDouble = Double(massTwo) else {return false}
            
            return massOneAsDouble > massTwoAsDouble
        }
        
    }
    
    private func storeMeteorDataInCorrectFormat(_ meteorsAsJson: [[String: Any]]) {
        
        var meteorsOrderedByMass = [MeteorData]()
        var meteorsWithoutMass = [MeteorData]()
        
        for meteorData in meteorsAsJson {
            
            var meteor = MeteorData()
            
            meteor.name = meteorData["name"] as? String
            meteor.mass = meteorData["mass"] as? String
            
            let yearAndTime = meteorData["year"] as? String
            let dateAsSubstring = yearAndTime?.split(separator: "T").first
            let dateFell = String(dateAsSubstring ?? "Unknown")
                
            meteor.fellAtDate = dateFell
        
            if let geolocation = meteorData["geolocation"] as? [String: Any] {
                if let coordinates = geolocation["coordinates"] as? [Double] {
                    meteor.geoLocation = GeoLocation(latitude: coordinates[1], longitude: coordinates[0])
                }
            }

            if meteor.mass != nil {
                meteorsOrderedByMass.append(meteor)
            } else {
                meteorsWithoutMass.append(meteor)
            }
            
        }
        
        entity.meteorsOrderedByMass = meteorsOrderedByMass
        entity.meteorsWithoutMass = meteorsWithoutMass
        entity.archive()
        
        updateTimeOfLastBackendSync()
    }
    
    private func updateTimeOfLastBackendSync() {
        let syncedAt = Date()
        entity.lastBackendSync = syncedAt
    }
    
}
extension HomeInteractor {
    func UIDidLoad() {
        showMeteors()
    }
    
    func didSelectMeteor(meteor: MeteorData) {
        delegate.didSelectMeteor(meteor: meteor)
    }
}
