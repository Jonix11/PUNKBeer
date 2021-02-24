//
//  Constants.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import Foundation

struct PunkAPIConstants {
    static func getAbsoluteURL() -> URL {
        //https://api.punkapi.com/v2/beers
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.punkapi.com"
        components.path = "/v2/beers"
        
        return components.url!
    }
    
//    static func getBeersURL(withQueryParams queryParams: [String]) -> URL {
//        
//    }
}
