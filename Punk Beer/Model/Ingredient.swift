//
//  Ingredient.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 22/2/21.
//

import Foundation

typealias Yeast = String

struct Amount {
    let value: Double
    let unit: String
}

struct Ingredients {
    let malt: [Ingredient]?
    let hops: [Ingredient]?
    let yeast: Yeast?
}

struct Ingredient {
    let name: String
    let amount: Amount?
    
    init(name: String, amount: Amount? = nil) {
        self.name = name
        self.amount = amount
    }
}

extension Ingredients: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case malt
        case hops
        case yeast
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        malt = try container.decodeIfPresent([Ingredient].self, forKey: .malt)
        hops = try container.decodeIfPresent([Ingredient].self, forKey: .hops)
        yeast = try container.decodeIfPresent(Yeast.self, forKey: .yeast)
    }
}

extension Ingredient: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case amount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        amount = try container.decodeIfPresent(Amount.self, forKey: .amount)
    }
}

extension Amount: Decodable {
    
}
