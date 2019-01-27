import XCTest
@testable import FallenMeteors

class MeteorSortingTest: XCTestCase {

    var meteorDataFormatter: MeteorDataFormatter!
    var jsonAsDict: [[String: Any]]!
    var unwantedResult: String!
    
    override func setUp() {
        super.setUp()
        
        meteorDataFormatter = MeteorDataFormatter()
        jsonAsDict = [
            
            [
                "mass": "1000000",
                "name": "CorkTheRealCapital",
                "year": "1930-03-03T00:00:00.000",
                "geolocation":
                    [
                        "coordinates":[-8.472855, 51.897760]
                ],
                ],
            
            [
                "mass": "900",
                "name": "DublinSecondBestCityInIreland",
                ],
            
            [
                "name": "TraleePrettyCoolButWhatAreTheySaying",
                "geolocation":
                    [
                        "coordinates":[-9.703248, 52.270904]
                ]
            ]
        ]
        
    }
    
    override func tearDown() {
        super.tearDown()
        jsonAsDict = nil
    }
    
    func testExample() {
        meteorDataFormatter.sortMeteorsByMass(&jsonAsDict)
        let meteorData = meteorDataFormatter.formatMeteorData(jsonAsDict)
        
        let meteorsWithMass = meteorData.meteorsWithMass
        for x in 0..<meteorsWithMass.count - 1 {
            XCTAssert(meteorsWithMass[x].mass != nil && meteorsWithMass[x + 1].mass != nil)
            
            guard let massOneAsDouble = Double(meteorsWithMass[x].mass!), let massTwoAsDouble = Double(meteorsWithMass[x + 1].mass!) else {XCTAssert(false); return}
            
            XCTAssert(massOneAsDouble > massTwoAsDouble)
        }
    }

}
