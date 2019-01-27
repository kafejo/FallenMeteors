import Foundation

struct MeteorData: Codable {
    var name: String?
    var mass: String?
    var geoLocation: GeoLocation?
    var fellAtDate: String?
    
    init() {
        //default init
    }
    
    init(name: String, mass:String, geoLocation:GeoLocation, fellAtDate :String) {
        self.name = name
        self.mass = mass
        self.geoLocation = geoLocation
        self.fellAtDate = fellAtDate
    }
}

struct GeoLocation: Codable {
    var latitude: Double?
    var longitude: Double?
    
    init() {
        //default init
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class HomeEntity: HomeEntityProtocol {
    
    var lastBackendSync: Date!
    
    var meteorsOrderedByMass: [MeteorData]?
    var meteorsWithoutMass: [MeteorData]?
    
    init() {
        lastBackendSync = Date()
    }

    static let storage = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveUrl = storage.appendingPathComponent("meteorData")
    
    func archive() {
        if let data = try? PropertyListEncoder().encode(self) {
            if !NSKeyedArchiver.archiveRootObject(data, toFile: HomeEntity.archiveUrl.path) {
                print("failed to perform archive")
            }
        }
    }
    
    static func retrieveArchive() -> HomeEntityProtocol {

        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: HomeEntity.archiveUrl.path) as? Data,
            let meteorData = try? PropertyListDecoder().decode(HomeEntity.self, from: data) else {
                try? FileManager.default.removeItem(at: HomeEntity.archiveUrl)
                return HomeEntity()
        }

        return meteorData
    }
    
}
