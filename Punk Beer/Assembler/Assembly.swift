//
//  Assembly.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import UIKit

class Assembler {
    static func provideSearchView() -> UIViewController {
        let searchView = SearchViewController()
        let beerService = BeerService(withApiConsumer: PunkAPIConsumer())
        let searchPresenter = SearchPresenter(withService: beerService, ui: searchView)
        searchView.configure(with: searchPresenter)
        
        return searchView
    }
}
