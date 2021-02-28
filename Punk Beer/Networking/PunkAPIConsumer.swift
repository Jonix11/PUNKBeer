//
//  PunkAPIConsumer.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import Foundation

class PunkAPIConsumer: PunkAPIConsumable {
    
    let session = URLSession.shared
    
    func getBeers(onSuccess success: @escaping ([Beer]) -> Void, failure: @escaping (Error) -> Void) {
        
        let url = PunkAPIConstants.getAbsoluteURL()
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let beerCollection = try decoder.decode([Beer].self, from: data)
                    DispatchQueue.main.async { success(beerCollection) }
                } catch {
                    DispatchQueue.main.sync { failure(error) }
                }
            }
        }
        task.resume()
    }
    
    func getSearchedBeers(withQueryParams queryParams: [String: String], success: @escaping ([Beer]) -> Void, failure: @escaping (Error) -> Void) {
        
        let url = PunkAPIConstants.getBeersURL(withQueryParams: queryParams)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let beerCollection = try decoder.decode([Beer].self, from: data)
                    DispatchQueue.main.async { success(beerCollection) }
                } catch {
                    DispatchQueue.main.async { failure(error) }
                }
            }
        }
        task.resume()
    }

}
