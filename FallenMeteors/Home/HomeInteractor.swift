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

        let jsonFormatter = MeteorDataFormatter()
        guard let meteorData = jsonFormatter.parseAndFormatMeteorData(data: data) else { return }
        storeMeteorData(meteorsOrderedByMass: meteorData.meteorsOrderedByMass, meteorsWithoutMass: meteorData.meteorsWithoutMass)
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
