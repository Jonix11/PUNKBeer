//
//  DetailViewController.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 25/2/21.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var firstBrewedLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var foodTableView: UITableView!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    let beer: Beer
    
    //MARK: - Initialization
    init(beer: Beer) {
        self.beer = beer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        foodTableView.dataSource = self
        foodTableView.delegate = self
        
        setupUI()
        syncModelWithView()
    }
    
    private func syncModelWithView() {
        beerImage.sd_setImage(with: beer.imageURL, placeholderImage: UIImage(named: "BeerBottle"))
        nameLabel.text = beer.name
        
        if let tagline = beer.tagline {
            taglineLabel.text = tagline
        } else {
            taglineLabel.text = "This beer doesn't have tagline"
        }
        
        if let firstBrewed = beer.firstBrewed {
            firstBrewedLabel.text = DateFormatter.beerAPIDateFormatter.string(from: firstBrewed)
        } else {
            firstBrewedLabel.text = "n/a"
        }
        
        if let abv = beer.abv {
            abvLabel.text = "\(abv)%"
        } else {
            abvLabel.text = "n/a"
        }
        
        if let description = beer.description {
            descriptionTextView.text = description
        } else {
            descriptionTextView.text = "This beer doesn't have description."
        }
        
        if let count = beer.foodPairing?.count {
            tableViewHeightConstraint.constant = CGFloat(count) * 30
            foodTableView.reloadData()
        } else {
            tableViewHeightConstraint.constant = 0
        }
    }
    
    func setupUI() {
        let ingredientsButton = UIBarButtonItem(title: "Ingredients", style: .plain, target: self, action: #selector(displayIngredients))
        navigationItem.rightBarButtonItem = ingredientsButton
    }

    @objc func displayIngredients() {
        let ingredientsView = IngredientsViewController(viewTitle: beer.name, ingredients: beer.ingredients)
        navigationController?.pushViewController(ingredientsView, animated: true)
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = beer.foodPairing?.count {
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = beer.foodPairing?[indexPath.row]
        
        let cellId = "foodCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = food
        cell?.imageView?.image = UIImage(named: "food")
        cell?.selectionStyle = .none
        
        return cell!
    }
}
