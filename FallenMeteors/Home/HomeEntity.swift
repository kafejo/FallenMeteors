import Foundation

struct MeteorData: Codable {
    var name: String?
    var mass: String?
    var geoLocation: GeoLocation?
    var year: String?
    
    init() {
        //default init
    }
    
    init(name: String, mass:String, geoLocation:GeoLocation, year:String) {
        self.name = name
        self.mass = mass
        self.geoLocation = geoLocation
        self.year = year
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
    
    var url: URL!
    var meteorsOrderedBySize: [MeteorData]!
    
    init() {
        //TODO maybe static
        url = URL(string: "https://data.nasa.gov/resource/y77d-th95.json")
    }

    //TODO double check
    static let storage = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveUrl = storage.appendingPathComponent("meteorData.bin")
    
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
