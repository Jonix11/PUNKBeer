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
    var filters: [String: String] = [:]
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
        
        title = "Beers"
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        state = .loading
        presenter.getInitialBeerList()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupUI() {
        let filterButton = UIBarButtonItem(title: "Filters", style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc func filterButtonTapped() {
        let filtersView = FiltersViewController(filters: filters)
        filtersView.delegate = self
        present(filtersView, animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        state = .loading
        if searchText.count == 0 {
            filters.removeValue(forKey: PunkAPIConstants.FOOD_FILTER)
            if filters.count == 0 {
                presenter.getInitialBeerList()
            } else {
                presenter.getSearchedBeerList(withQueryParams: filters)
            }
        } else {
            filters.updateValue(searchText, forKey: PunkAPIConstants.FOOD_FILTER)
            presenter.getSearchedBeerList(withQueryParams: filters)
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = model[indexPath.row]
        let detailView = DetailViewController(beer: beer)
        navigationController?.pushViewController(detailView, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let beer = model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.reusableId, for: indexPath) as! SearchViewCell
        cell.beer = beer
        cell.selectionStyle = .none
        
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

extension SearchViewController: FiltersViewControllerDelegate {
    func filtersViewController(_ filtersViewController: FiltersViewController, didApplyFilters filters: [String : String]) {
        self.filters = filters
        let othersFilters = filters.keys.filter {
            $0 != "food"
        }
        if othersFilters.count == 0 {
            navigationItem.rightBarButtonItem?.title = "Filters"
        } else {
            navigationItem.rightBarButtonItem?.title = "Filters(\(othersFilters.count))"
        }
        state = .loading
        if self.filters.count == 0 {
            presenter.getInitialBeerList()
        } else {
            presenter.getSearchedBeerList(withQueryParams: self.filters)
        }
    }
}
