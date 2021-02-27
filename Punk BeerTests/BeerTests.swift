//
//  BeerTests.swift
//  Punk BeerTests
//
//  Created by Jon Gonzalez on 22/2/21.
//

import XCTest
@testable import Punk_Beer

class BeerTests: XCTestCase {
    
    var beer: Beer!
    var amount: Amount!
    var amount2: Amount!
    var malt: Ingredient!
    var hop: Ingredient!
    var hop2: Ingredient!
    var yeast: Yeast!
    var ingredients: Ingredients!
    

    override func setUpWithError() throws {
        
        amount = Amount(value: 3.2, unit: "Kilograms")
        amount2 = Amount(value: 11.6, unit: "Grams")
        
        malt = Ingredient(name: "One malt", amount: amount2)
        hop = Ingredient(name: "One hop", amount: amount)
        hop2 = Ingredient(name: "Two hop", amount: amount2)
        yeast = "One yeast"
        ingredients = Ingredients(malt: [malt], hops: [hop, hop2], yeast: yeast)
        
        let imageURL = URL(string: "https://images.punkapi.com/v2/192.png")
        beer = Beer(beerId: 1, name: "One beer", tagline: "A tagline", firstBrewed: Date(), description: "Awesome beer with description", imageURL: imageURL, abv: 8.3, foodPairing: ["Paella", "Beef ribeye"], ingredients: ingredients)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBeerExistence() {
        XCTAssertNotNil(beer)
    }
    
    func testAmountExistence() {
        XCTAssertNotNil(amount2)
    }
    
    func testIngredientExistence() {
        XCTAssertNotNil(malt)
    }
    
    func testIngredientsExistence() {
        XCTAssertNotNil(ingredients)
    }
    
    func testDecodeBeerCollection() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "beer-search-result", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            
            let beerCollection = try decoder.decode([Beer].self, from: data)
            XCTAssertNotNil(beerCollection)
            let firstBeer = beerCollection.first
            XCTAssertNotNil(firstBeer?.beerId)
            XCTAssertNotNil(firstBeer?.name)
            XCTAssertNotNil(firstBeer?.tagline)
            XCTAssertNotNil(firstBeer?.firstBrewed)
            XCTAssertNotNil(firstBeer?.description)
            XCTAssertNotNil(firstBeer?.imageURL)
            XCTAssertNotNil(firstBeer?.abv)
            XCTAssertNotNil(firstBeer?.ingredients.malt)
            XCTAssertNotNil(firstBeer?.ingredients.hops)
            XCTAssertNotNil(firstBeer?.ingredients.yeast)
            
        } catch {
            XCTFail()
        }
    }
    
    func testAmountHasDescription() {
        XCTAssertNotNil(amount.description)
    }

}
