import XCTest
@testable import FallenMeteors

class FallenMeteorsTests: XCTestCase {
    
    var meteorDataFormatter: MeteorDataFormatter!
    var json: [[String: Any]]!
    var unwantedResult: String!
    
    override func setUp() {
        super.setUp()
        
        meteorDataFormatter = MeteorDataFormatter()
        json = [

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
                "geolocation":
                    [
                        "coordinates":[-6.269688, 53.343458]
                ]
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
        json = nil
    }

    func testExample() {
        let meteorData = meteorDataFormatter.formatMeteorData(json)
        
        for meteor in meteorData.meteorsWithMass {
            XCTAssert(meteor.name != nil)
            XCTAssert(meteor.mass != nil)
            XCTAssert(meteor.fellAtDate != nil)
            XCTAssert(meteor.geoLocation != nil)
        }
    }

}
