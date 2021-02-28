//
//  SearchPresenter.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import Foundation

class SearchPresenter {
    
    //MARK: - Properties
    public private(set) var service: BeerService
    public private(set) weak var ui: SearchViewProtocol?
    
    //MARK: - Initialization
    init(withService service: BeerService, ui: SearchViewProtocol) {
        self.service = service
        self.ui = ui
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    
    func getInitialBeerList() {
        service.getBeer(onSuccess: { [weak self] (beers) in
            if beers.count == 0 {
                self?.ui?.setEmptyStatus()
            } else {
                self?.ui?.setBeerList(with: beers)
            }
        }, failure: { [weak self] (error) in
            self?.ui?.setFailureStatus()
        })
    }    
    
    func getSearchedBeerList(withQueryParams queryParams: [String: String]) {
        service.getSearchedBeers(withQueryParams: queryParams, success: { [weak self] (beers) in
            if beers.count == 0 {
                self?.ui?.setEmptyStatus()
            } else {
                self?.ui?.setBeerList(with: beers)
            }
        }, failure: {[weak self] (error) in
            self?.ui?.setFailureStatus()
        })
    }
    
    func saveFilters(_ filters: [String: String]) {
        print(filters)
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(filters, forKey: PunkAPIConstants.SAVED_FILTERS)
    }
    
    func retrieveSavedFilters() {
        let userDefaults = UserDefaults.standard
        let retrievedFilters = userDefaults.dictionary(forKey: PunkAPIConstants.SAVED_FILTERS) as! [String: String]
        print(retrievedFilters)
        ui?.setRetrievedFilters(withFilters: retrievedFilters)
    }
    
}
