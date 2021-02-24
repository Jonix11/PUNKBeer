//
//  SearchViewCell.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 24/2/21.
//

import UIKit
import SDWebImage

class SearchViewCell: UITableViewCell {
    
    static let nibName = String(describing: SearchViewCell.self)
    static let reusableId = String(describing: SearchViewCell.self)
    
    //MARK: - Outlets
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var firstBrewedLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    
    //MARK: - Properties
    var beer: Beer! {
        didSet {
            beerImageView.sd_setImage(with: beer.imageURL, placeholderImage: UIImage(named: "BeerBottle"))
            nameLabel.text = beer.name
            if let tagline = beer.tagline {
                taglineLabel.text = tagline
            } else {
                taglineLabel.isHidden = true
            }
            if let firstBrewed = beer.firstBrewed {
                let firstBrewedString = DateFormatter.beerAPIDateFormatter.string(from: firstBrewed)
                firstBrewedLabel.text = firstBrewedString
            } else {
                firstBrewedLabel.text = "n/a"
            }
            if let abv = beer.abv {
                abvLabel.text = "\(abv)%"
            } else {
                abvLabel.text = "n/a"
            }
        }
    }
    
    //MARK: - Life Cycle
    override func prepareForReuse() {
        beerImageView.sd_cancelCurrentImageLoad()
        taglineLabel.isHidden = false
    }
    
}
