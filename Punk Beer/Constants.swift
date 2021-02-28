//
//  Constants.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import Foundation

struct PunkAPIConstants {
    static func getAbsoluteURL() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.punkapi.com"
        components.path = "/v2/beers"
        
        return components.url!
    }
    
    static func getBeersURL(withPairingFood food: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.punkapi.com"
        components.path = "/v2/beers"
        components.queryItems = [URLQueryItem(name: "food", value: food)]
        
        return components.url!
    }
    
    static func getBeersURL(withQueryParams queryParams: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.punkapi.com"
        components.path = "/v2/beers"
        components.queryItems = []
        queryParams.forEach {
            components.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        return components.url!
    }
    
    static let FOOD_FILTER = "food"
    static let GREATER_FILTER = "abv_gt"
    static let LESS_FILTER = "abv_lt"
}
