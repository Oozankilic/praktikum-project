//
//  ShoppingList.swift
//  Recipes
//
//  Created by Ferhat Turhan on 15.10.2023.
//

import Foundation
import SwiftData

@Model public class ShoppingList: Identifiable {
    public var name: String
    var ingredients: [Ingredient]
    var selected = [""]
    
    init(name: String, ingredients: [Ingredient]) {
        self.name = name
        self.ingredients = ingredients
    }
}
