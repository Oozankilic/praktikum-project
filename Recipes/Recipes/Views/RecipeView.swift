//
//  RecipeView.swift
//  Recipes
//
//  Created by Ozan Kılıç on 15.10.2023.
//

import SwiftUI
import SwiftData

struct RecipeView: View {
    @State private var viewModel = RecipeViewModel()
    @Binding private var recipe: Recipe
    @Environment(\.modelContext) private var modelContext: ModelContext
    @State var shoppingList = ShoppingList(name: "", ingredients: [])
    @Environment(\.dismiss) private var dismiss
    @State private var showShoppingBasketView = false
    
    init(recipe: Binding<Recipe>) {
        _recipe = recipe
        viewModel.recipeId = recipe.wrappedValue.id
        viewModel.performSearch()
    }
    
    var body: some View {
        if $viewModel.isLoading.wrappedValue {
            ProgressView()
        } else {
            Section(header: Text(recipe.title).font(.title).padding(.vertical, 10)) {
                List(viewModel.ingredients, id: \.name) { ingredient in
                    HStack {
                        Text(String(format:"%.2f \(ingredient.amount.metric.unit)", ingredient.amount.metric.value))
                            .bold()
                        Text("of ")
                        Text("\(ingredient.name)")
                            .bold()
                    }
                }
                Button(action: {
                    shoppingList.name = recipe.title
                    shoppingList.ingredients = viewModel.ingredients
                    do {
                        try modelContext.delete(model: ShoppingList.self)
                    } catch {
                        print("There is no such data")
                    }
                    modelContext.insert(shoppingList)
                    dismiss()
                }) {
                    Text("Add Ingredients to the Basket")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}
