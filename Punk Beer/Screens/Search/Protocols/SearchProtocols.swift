//
//  SearchProtocols.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import Foundation

protocol SearchPresenterProtocol {
    func getInitialBeerList()
}

protocol SearchViewProtocol: AnyObject {
    func setBeerList(with beers: [Beer])
}
