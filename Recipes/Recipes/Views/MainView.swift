//
//  ContentView.swift
//  Recipes
//
//  Created by Ferhat Turhan on 14.10.2023.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Query var shoppingLists: [ShoppingList]
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if colorScheme == .light {
                Color.black
            }
            NavigationView {
                VStack {
                    NavigationLink(destination: SearchView()) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search Recipes")
                        }
                        .padding()
                        .frame(minWidth: 190)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding(.vertical, 30)
                    NavigationLink(destination: ShoppingBasketView()) {
                        HStack {
                            Image(systemName: "cart")
                            Text("Shopping Basket")
                        }
                        .padding()
                        .frame(minWidth: 190)
                        .background(shoppingLists.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(shoppingLists.isEmpty ? Color.black : Color.white)
                        .cornerRadius(8)
                    }
                    .disabled(shoppingLists.isEmpty)
                    Spacer()
                }
                .navigationTitle("Recipes Menu")
                .font(Font.custom("KitchenCookies", size: 18))
            }
        }
    }
}

#Preview {
    MainView()
}
