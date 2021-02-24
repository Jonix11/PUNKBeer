//
//  BeerService.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import Foundation

class BeerService {
    
    //MARK: - Properties
    let apiConsumer: PunkAPIConsumable
    
    //MARK: - Initialization
    init(withApiConsumer apiConsumer: PunkAPIConsumable) {
        self.apiConsumer = apiConsumer
    }
    
    func getBeer(onSuccess success: @escaping ([Beer]) -> Void, failure: @escaping (Error) -> Void) {
        apiConsumer.getBeers(onSuccess: { (beers) in
            assert(Thread.current == Thread.main)
            success(beers)
        }, failure: { (error) in
            assert(Thread.current == Thread.main)
            failure(error)
        })
    }
}
