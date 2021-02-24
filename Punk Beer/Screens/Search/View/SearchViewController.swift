//
//  SearchViewController.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import UIKit

enum ViewState {
    case loading
    case failure
    case empty
    case success
}

class SearchViewController: UIViewController {
    
    //MARK: - Properties
    var model: [Beer] = []
    var state: ViewState = .success {
        willSet {
            guard newValue != state else { return }
            
            switch newValue {
            case .loading:
                [stateView, loadingIndicator].forEach { $0?.isHidden = false }
                [stateLabel, stateImage].forEach { $0?.isHidden = true }
            case .failure:
                [stateView,stateLabel, stateImage].forEach { $0?.isHidden = false }
                loadingIndicator.isHidden = true
                stateLabel.text = "There was a problem loading beers list"
                stateImage.image = UIImage(systemName: "xmark.circle.fill")
                stateImage.tintColor = UIColor.systemRed
            case .empty:
                [stateView,stateLabel, stateImage].forEach { $0?.isHidden = false }
                loadingIndicator.isHidden = true
                stateLabel.text = "There aren't beers that fit the search"
                stateImage.image = UIImage(systemName: "info.circle.fill")
                stateImage.tintColor = UIColor.systemBlue
            case .success:
                stateView.isHidden = true
            }
        }
    }
    
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
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        state = .loading
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
        state = .success
    }
    
    func setEmptyStatus() {
        state = .empty
    }
    
    func setFailureStatus() {
        state = .failure
    }
}
