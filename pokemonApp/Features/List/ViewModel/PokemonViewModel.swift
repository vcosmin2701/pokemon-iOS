import Foundation
import Apollo
import PokeAPI

@Observable
class PokemonViewModel {
    var pokemonList: [Pokemon] = []
    var isLoading: Bool = true
    var searchOption: String = ""
    
    private let apolloClient = ApolloClient(url: URL(string: "https://beta.pokeapi.co/graphql/v1beta")!)
    
    var filteredPokemonList: [Pokemon] {
        if searchOption.isEmpty {
            return self.pokemonList
        } else {
            return pokemonList.filter { pokemon in
                pokemon.name.lowercased().hasPrefix(searchOption.lowercased())
            }
        }
    }
    
    func fetchPokemon() {
        let query = PokemonGraphQLCallQuery()
        apolloClient.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):
                if let pokemons = graphQLResult.data?.pokemon_v2_pokemon {
                    self.pokemonList = PokemonFactory.createPokemons(from: pokemons)
                }
            case .failure(let error):
                print("Error loading Pokémon: \(error.localizedDescription)")
            }
            self.isLoading = false
        }
    }
}
