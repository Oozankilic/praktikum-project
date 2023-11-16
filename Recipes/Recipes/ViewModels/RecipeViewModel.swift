//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Ferhat Turhan on 15.10.2023.
//

import Foundation
import os

@Observable class RecipeViewModel {
    var recipeId: Int?
    var isLoading = true
    var ingredients: [Ingredient] = []
    let logger = Logger()
    
    func performSearch() {
        if let recipeId = recipeId, let url = URL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(recipeId)/ingredientWidget.json") {
            var request = URLRequest(url: url)
            
            request.setValue("ccd9335536msh1718c7a7d98511dp1f2f11jsnb313570d43c1", forHTTPHeaderField: "X-RapidAPI-Key")
            request.setValue("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

            request.httpMethod = "GET"
            request.cachePolicy = .useProtocolCachePolicy
            request.timeoutInterval = 10
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(IngredientResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.ingredients = result.ingredients
                            self.isLoading = false
                        }
                    } catch {
                        self.logger.log("Error: \(error)")
                        self.isLoading = false
                    }
                } else if let error = error {
                    self.logger.log("Network Error: \(error)")
                    self.isLoading = false
                }
            }
            .resume()
        }
    }
}

struct IngredientResponse: Codable {
    let ingredients: [Ingredient]
}

struct Ingredient: Codable {
    let name: String
    let amount: Amount
}

struct Amount: Codable {
    let metric: Measurement
    let us: Measurement
}

struct Measurement: Codable {
    let value: Double
    let unit: String
}
