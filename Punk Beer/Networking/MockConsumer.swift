//
//  MockConsumer.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import Foundation

class MockConsumer: PunkAPIConsumable {
    
    func getBeers(onSuccess success: @escaping ([Beer]) -> Void, failure: @escaping (Error) -> Void) {
        DispatchQueue.main.async {
            success([Beer(beerId: 1, name: "One beer"), Beer(beerId: 2, name: "Two beer"), Beer(beerId: 3, name: "Three beer")])
        }
    }
    
    func getSearchedBeers(byFood food: String, success: @escaping ([Beer]) -> Void, failure: @escaping (Error) -> Void) {
        DispatchQueue.main.async {
            success([Beer(beerId: 1, name: "One beer"), Beer(beerId: 2, name: "Two beer"), Beer(beerId: 3, name: "Three beer")])
        }
    }
    
}
