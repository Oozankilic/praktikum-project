import SwiftUI

struct SearchView: View {
    @State var viewModel = SearchViewModel()
    @State var isRecipePresented = false
    @State private var recipePresented: [Recipe.ID: Bool] = [:]

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(searchText: $viewModel.searchText)
                    .onChange(of: viewModel.searchText) { _, _ in
                        viewModel.performSearch()
                    }
                    .frame(alignment: .top)
                
                if viewModel.recipes.isEmpty {
                    ContentUnavailableView.search
                }

                ForEach(viewModel.recipes) { recipe in
                    let isRecipePresented = Binding<Bool>(
                        get: { return self.recipePresented[recipe.id] ?? false },
                        set: { self.recipePresented[recipe.id] = $0 }
                    )

                    Button(action: {
                        isRecipePresented.wrappedValue.toggle()
                    }) {
                        Text(recipe.title)
                            .padding()
                            .foregroundColor(colorScheme == .dark ? .white : .primary)
                    }
                    .frame(maxWidth: .infinity)
                    .background(colorScheme == .dark ? .gray : .yellow)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .sheet(isPresented: isRecipePresented) {
                        if let selectedRecipe = $viewModel.recipes.first(where: { $0.id == recipe.id }) {
                            RecipeView(recipe: selectedRecipe)
                        }
                    }
                }
            }
        }
    }
}
