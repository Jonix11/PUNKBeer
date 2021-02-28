//
//  SearchProtocols.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import Foundation

protocol SearchPresenterProtocol {
    func getInitialBeerList()
    func getSearchedBeerList(withQueryParams queryParams: [String: String])
    func saveFilters(_ filters: [String: String])
    func retrieveSavedFilters()
}

protocol SearchViewProtocol: AnyObject {
    func setBeerList(with beers: [Beer])
    func setEmptyStatus()
    func setFailureStatus()
    func setRetrievedFilters(withFilters filters: [String: String])
}
