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
            self?.ui?.setBeerList(with: beers)
        }, failure: { [weak self] (error) in
            #warning("TODO")
        })
    }
    
    
}
