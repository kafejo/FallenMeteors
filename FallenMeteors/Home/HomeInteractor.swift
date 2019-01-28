import Foundation

class HomeInteractor: HomeInteractorProtocol {
    
    weak var delegate: HomeInteractorDelegate!
    var entity: HomeEntityProtocol!
    var presenter: HomePresenterProtocol!
    
    var timer: Timer!
    var dataRequestHandler: MeteorDataRequestHandler!
    
    let backendSyncSchedule = 86400.0
    
    func showMeteors() {
        
        guard let meteorsOrderedByMass = entity.meteorsOrderedByMass, let meteorsWithoutMass = entity.meteorsWithoutMass else {return}
        
        presenter.showMeteorData(meteorsOrderedByMass: meteorsOrderedByMass, meteorsWithoutMass: meteorsWithoutMass)
    }
    
    func beginBackendSyncHeartbeat() {
        timer = Timer()
        
        // Why scheduling timer for every 10 seconds when the sync is set to perform for every 86400 seconds?
        // It's highly ineffective to check such a large dataset every 10 seconds when it possibly changes only once every 24 hours
        timer.oneHeartBeat = { [weak self] in
            guard let lastSync = self?.entity.lastBackendSync else { return }
            if(NSDate().timeIntervalSince(lastSync) >= (self?.backendSyncSchedule)!) {
                self?.loadData()
            }
        }
    }

    func loadData() {
        dataRequestHandler = MeteorDataRequestHandler()
        dataRequestHandler.loadData() { [weak self] (result) in
            self?.parseJSONIntoMeteorData(data: result)
        }
    }

    private func parseJSONIntoMeteorData(data: Data){

        let meteorFormatter = MeteorDataFormatter()
        
        // Error states are not handled at all
        guard var meteorDataAsJson = meteorFormatter.parseJSON(data: data) else { return }
        meteorFormatter.sortMeteorsByMass(&meteorDataAsJson)
        let meteorData = meteorFormatter.formatMeteorData(meteorDataAsJson)
        
        storeMeteorData(meteorsOrderedByMass: meteorData.meteorsWithMass, meteorsWithoutMass: meteorData.meteorsWithoutMass)
        showMeteors()
    }
    
    private func storeMeteorData(meteorsOrderedByMass: [MeteorData], meteorsWithoutMass: [MeteorData]) {
        
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
