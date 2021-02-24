//
//  SearchViewController.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Properties
    var model: [Beer] = []
    
    //MARK: - Presenter Elements
    public private(set) var presenter: SearchPresenterProtocol!
    
    func configure(with presenter: SearchPresenterProtocol) {
        self.presenter = presenter
    }
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: SearchViewCell.nibName, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: SearchViewCell.reusableId)
        }
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        presenter.getInitialBeerList()
    }
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let beer = model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.reusableId, for: indexPath) as! SearchViewCell
        cell.beer = beer
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

extension SearchViewController: SearchViewProtocol {
    func setBeerList(with beers: [Beer]) {
        model = beers
        tableView.reloadData()
    }
    
    
}
