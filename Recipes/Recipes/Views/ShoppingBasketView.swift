//
//  ShoppingBasketView.swift
//  Recipes
//
//  Created by Ferhat Turhan on 14.10.2023.
//

import SwiftUI
import SwiftData
import ConfettiView

struct ShoppingBasketView: View {
    @Query var shoppingLists: [ShoppingList]
    
    var body: some View {
        var basket = shoppingLists[0]
        
        VStack {
            ForEach(basket.ingredients, id: \.name) { ingredient in
                Button(action: {
                    if !basket.selected.contains(ingredient.name) {
                        basket.selected.append(ingredient.name)
                    } else {
                        if let index = basket.selected.firstIndex(of: ingredient.name) {
                            basket.selected.remove(at: index)
                        }
                    }
                },
                label: {
                    if basket.selected.contains(ingredient.name) {
                        HStack {
                            Text(String(format:"%.2f \(ingredient.amount.metric.unit)", ingredient.amount.metric.value) + " of \(ingredient.name)")
                        }
                        .strikethrough()
                        .colorMultiply(.gray)
                        .font(.title3)
                        .padding(5)
                    } else {
                        Text(String(format:"%.2f \(ingredient.amount.metric.unit)", ingredient.amount.metric.value) + " of \(ingredient.name)")
                            .font(.title2)
                            .padding(5)
                    }
                })
            }
        }
        Spacer()
        if basket.selected.count - 1 == basket.ingredients.count {
            ConfettiView(confetti: [
                .text("🍅"),
                .text("🍆"),
                .text("🥬"),
            ])
            .allowsHitTesting(false)
        }
    }
}
