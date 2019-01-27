import Foundation

class MeteorDataFormatter {
    
    func parseAndFormatMeteorData(data: Data) -> (meteorsOrderedByMass: [MeteorData], meteorsWithoutMass: [MeteorData])? {
        
        guard var meteorDataAsJson = parseJSON(data: data) else { return nil }
        sortMeteorsByMass(&meteorDataAsJson)
        return formatMeteorData(meteorDataAsJson)
        
    }
    
    private func parseJSON(data: Data) -> [[String: Any]]?{
        
        var jsonResult: Any!
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        } catch let error {
            print("Unable to parse Json. Error: \(error.localizedDescription)")
            return nil
        }
        
        guard let meteorDataAsJson = jsonResult as? [[String: Any]] else { print("Unable to parse Json"); return nil}
        return meteorDataAsJson

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
    
    private func formatMeteorData(_ meteorsData: [[String: Any]]) -> (meteorsOrderedByMass: [MeteorData], meteorsWithoutMass: [MeteorData]){
        
        var meteorsOrderedByMass = [MeteorData]()
        var meteorsWithoutMass = [MeteorData]()
        
        for meteorData in meteorsData {
            
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
            }
            else {
                meteorsWithoutMass.append(meteor)
            }
            
        }
        
        return (meteorsOrderedByMass, meteorsWithoutMass)
        
    }
    
}
