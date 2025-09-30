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
                    self.pokemonList = pokemons.compactMap { pokemon in
                        let sprite = pokemon.pokemon_v2_pokemonsprites.first?.sprites
                        let types: [String] = pokemon.pokemon_v2_pokemontypes.map { item in
                            if let temp = item.pokemon_v2_type {
                                return temp.name
                            }
                            return "unknown"
                        }
                        
                        let stats: [PokemonStatType] = pokemon.pokemon_v2_pokemonstats.map { item in
                            if let temp = item.pokemon_v2_stat {
                                return PokemonStatType(name: temp.name, baseStat: item.base_stat)
                            }
                            return PokemonStatType(name: "", baseStat: 0)
                        }
                        return Pokemon(id: pokemon.id, name: pokemon.name.capitalized, height: pokemon.height ?? 0, weight: pokemon.height ?? 0, sprite: sprite ?? "", type: types, stats: stats)
                    }
                }
            case .failure(let error):
                print("Error loading Pokémon: \(error.localizedDescription)")
            }
            self.isLoading = false
        }
    }
}
