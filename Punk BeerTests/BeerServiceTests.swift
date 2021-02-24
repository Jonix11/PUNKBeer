//
//  BeerServiceTests.swift
//  Punk BeerTests
//
//  Created by Jon Gonzalez on 24/2/21.
//

import XCTest
@testable import Punk_Beer


class BeerServiceTests: XCTestCase {
    
    var beerService: BeerService!

    override func setUpWithError() throws {
        beerService = BeerService(withApiConsumer: MockConsumer())
    }
    
    func testGetBeerListWithBeerService() {
        beerService.getBeer(onSuccess: { (beers) in
            XCTAssertNotNil(beers)
            XCTAssertGreaterThan(beers.count, 0)
            XCTAssertNotNil(beers.first?.beerId)
        }, failure: { (_) in
            XCTFail()
        })
    }

}
