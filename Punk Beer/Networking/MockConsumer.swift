//
//  MockConsumer.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import Foundation

class MockConsumer: PunkAPIConsumable {
    
    
    
    func getBeers(onSuccess success: @escaping ([Beer]) -> Void, failure: @escaping (Error) -> Void) {
        let amount = Amount(value: 3.2, unit: "Kilograms")
        let amount2 = Amount(value: 11.6, unit: "Grams")
        
        let malt = Ingredient(name: "One malt", amount: amount2)
        let hop = Ingredient(name: "One hop", amount: amount)
        let hop2 = Ingredient(name: "Two hop", amount: amount2)
        let yeast = "One yeast"
        let ingredients = Ingredients(malt: [malt], hops: [hop, hop2], yeast: yeast)
        DispatchQueue.main.async {
            success([Beer(beerId: 1, name: "One beer", ingredients: ingredients), Beer(beerId: 2, name: "Two beer", ingredients: ingredients), Beer(beerId: 3, name: "Three beer", ingredients: ingredients)])
        }
    }
    
    func getSearchedBeers(byFood food: String, success: @escaping ([Beer]) -> Void, failure: @escaping (Error) -> Void) {
        let amount = Amount(value: 3.2, unit: "Kilograms")
        let amount2 = Amount(value: 11.6, unit: "Grams")
        
        let malt = Ingredient(name: "One malt", amount: amount2)
        let hop = Ingredient(name: "One hop", amount: amount)
        let hop2 = Ingredient(name: "Two hop", amount: amount2)
        let yeast = "One yeast"
        let ingredients = Ingredients(malt: [malt], hops: [hop, hop2], yeast: yeast)
        DispatchQueue.main.async {
            success([Beer(beerId: 1, name: "One beer", ingredients: ingredients), Beer(beerId: 2, name: "Two beer", ingredients: ingredients), Beer(beerId: 3, name: "Three beer", ingredients: ingredients)])
        }
    }
    
}
