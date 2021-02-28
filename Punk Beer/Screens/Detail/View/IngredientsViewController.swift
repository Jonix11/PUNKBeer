//
//  IngredientsViewController.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 27/2/21.
//

import UIKit

class IngredientsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    //MARK: - Properties
    let viewTitle: String
    let ingredients: Ingredients
    
    //MARK: - Initialization
    init(viewTitle: String, ingredients: Ingredients) {
        self.viewTitle = viewTitle
        self.ingredients = ingredients
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewTitle
        ingredientsTableView.dataSource = self
    }
}

extension IngredientsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "Malt" }
        if section == 1 { return "Hops" }
        if section == 2 { return "Yeast" } else { return "" }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return ingredients.malt.count
        case 1:
            return ingredients.hops.count
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cellId = "MaltCell"
            let ingredient = ingredients.malt[indexPath.row]
            var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            if cell == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
            }
            cell?.textLabel?.text = ingredient.name
            cell?.detailTextLabel?.text = ingredient.amount?.description
            cell?.selectionStyle = .none
            
            return cell!
        case 1:
            let cellId = "HopsCell"
            let ingredient = ingredients.hops[indexPath.row]
            var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            if cell == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
            }
            cell?.textLabel?.text = ingredient.name
            cell?.detailTextLabel?.text = ingredient.amount?.description
            cell?.selectionStyle = .none
            
            return cell!
        case 2:
            let cellId = "YeastCell"
            let ingredient = ingredients.yeast
            var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
            }
            cell?.textLabel?.text = ingredient
            cell?.selectionStyle = .none
            
            return cell!
        default:
            return UITableViewCell()
        }
    }
}
