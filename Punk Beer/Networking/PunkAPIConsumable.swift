//
//  PunkAPIConsumable.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import Foundation

protocol PunkAPIConsumable {
    func getBeers(onSuccess success: @escaping ([Beer]) -> Void, failure: @escaping (Error) -> Void)
    func getSearchedBeers(withQueryParams queryParams: [String: String], success: @escaping ([Beer]) -> Void, failure: @escaping (Error) -> Void)
}
