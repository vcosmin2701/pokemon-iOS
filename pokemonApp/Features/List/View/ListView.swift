import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = PokemonViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Content is loading..")
                } else if viewModel.filteredPokemonList.isEmpty{
                    Text("Not found")
                } else {
                    List(viewModel.filteredPokemonList) { pokemon in
                        HStack {
                            AsyncImage(url: URL(string: pokemon.sprite), scale: 3)
                            NavigationLink(pokemon.name, value: pokemon)
                        }
                    }
                }
            }
            .navigationDestination(for: Pokemon.self) { pokemon in
                let viewModel = DetailsViewModel(pokemon: pokemon)
                PokemonDetailsView(detailsModel: viewModel)
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Home")
            .searchable(text: $viewModel.searchOption, prompt: "Search for a pokemon")
        }
        .onAppear {
            viewModel.fetchPokemon()
        }
    }
}

