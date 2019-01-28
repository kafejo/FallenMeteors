import Foundation

class MeteorDataFormatter {

    func parseJSON(data: Data) -> [[String: Any]]?{
        
        var json: Any!
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        } catch let error {
            print("Unable to parse Json. Error: \(error.localizedDescription)")
            return nil
        }
        
        guard let meteorDataAsJson = json as? [[String: Any]] else { print("Unable to parse Json"); return nil}
        return meteorDataAsJson

    }
    
    func sortMeteorsByMass(_ meteorData: inout [[String: Any]]) {
        
        meteorData.sort{
            guard let massOne = ($0["mass"] as? String) else { return false }
            guard let massTwo = ($1["mass"] as? String) else { return true }
            
            guard let massOneAsDouble = Double(massOne), let massTwoAsDouble = Double(massTwo) else {return false}
            
            return massOneAsDouble > massTwoAsDouble
        }
        
    }
    
    func formatMeteorData(_ meteorsData: [[String: Any]]) -> (meteorsWithMass: [MeteorData], meteorsWithoutMass: [MeteorData]){
        
        var meteorsWithMass = [MeteorData]()
        var meteorsWithoutMass = [MeteorData]()
        
        for meteorData in meteorsData {
            
            var meteor = MeteorData()
            
            meteor.name = meteorData["name"] as? String
            meteor.mass = meteorData["mass"] as? String
            
            let yearAndTime = meteorData["year"] as? String
            // Date formatter should been used instead!
            let dateAsSubstring = yearAndTime?.split(separator: "T").first
            let dateFell = String(dateAsSubstring ?? "Unknown")
            
            meteor.fellAtDate = dateFell
            
            if let geolocation = meteorData["geolocation"] as? [String: Any] {
                if let coordinates = geolocation["coordinates"] as? [Double] {
                    meteor.geoLocation = GeoLocation(latitude: coordinates[1], longitude: coordinates[0])
                }
            }
            
            if meteor.mass != nil {
                meteorsWithMass.append(meteor)
            }
            else {
                meteorsWithoutMass.append(meteor)
            }
            
        }
        
        return (meteorsWithMass, meteorsWithoutMass)
        
    }
    
}
