//
//  MeteorSortingTest.swift
//  FallenMeteorsTests
//
//  Created by Darragh King on 27/01/2019.
//  Copyright © 2019 Darragh King. All rights reserved.
//

import XCTest
@testable import FallenMeteors

class MeteorSortingTest: XCTestCase {

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
        meteorDataFormatter.sortMeteorsByMass(&json)
        let meteorData = meteorDataFormatter.formatMeteorData(json)
        
        let meteorsWithMass = meteorData.meteorsWithMass
        for x in 0..<meteorsWithMass.count - 1 {
            XCTAssert(meteorsWithMass[x].mass != nil && meteorsWithMass[x + 1].mass != nil)
            
            guard let massOneAsDouble = Double(meteorsWithMass[x].mass!), let massTwoAsDouble = Double(meteorsWithMass[x + 1].mass!) else {XCTAssert(false); return}
            
            XCTAssert(massOneAsDouble > massTwoAsDouble)
        }
    }

}
