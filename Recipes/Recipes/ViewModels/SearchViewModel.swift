import SwiftUI
import Combine
import os

@Observable class SearchViewModel {
    var recipes: [Recipe] = []
    var searchText = ""
    let logger = Logger()
    
    init() {
        performSearch()
    }
    
    func performSearch() {
        if let url = URL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?query=\(searchText)&number=20") {
            var request = URLRequest(url: url)
            
            request.setValue("ccd9335536msh1718c7a7d98511dp1f2f11jsnb313570d43c1", forHTTPHeaderField: "X-RapidAPI-Key")
            request.setValue("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

            request.httpMethod = "GET"
            request.cachePolicy = .useProtocolCachePolicy
            request.timeoutInterval = 10
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let data = data {
                    do {
                        let results = try JSONDecoder().decode(SearchResults.self, from: data)
                        DispatchQueue.main.async {
                            self.recipes = results.results
                        }
                    } catch {
                        self.logger.log("Error: \(error)")
                    }
                } else if let error = error {
                    self.logger.log("Network Error: \(error)")
                }
            }
            .resume()
        }
    }
}

struct Recipe: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}

struct SearchResults: Codable {
    let results: [Recipe]
    let offset: Int
    let number: Int
    let totalResults: Int
}
