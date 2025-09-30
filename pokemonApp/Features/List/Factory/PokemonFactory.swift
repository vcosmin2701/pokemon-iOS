import Foundation
import PokeAPI

struct PokemonFactory: PokemonFactoryProtocol {
    func createPokemon(from data: PokemonGraphQLCallQuery.Data.Pokemon_v2_pokemon) -> Pokemon {
        let sprite = data.pokemon_v2_pokemonsprites.first?.sprites
        
        let types: [String] = data.pokemon_v2_pokemontypes.map { item in
            if let temp = item.pokemon_v2_type {
                return temp.name
            }
            return "unknown"
        }
        
        let stats: [PokemonStatType] = data.pokemon_v2_pokemonstats.map { item in
            if let temp = item.pokemon_v2_stat {
                return PokemonStatType(name: temp.name, baseStat: item.base_stat)
            }
            return PokemonStatType(name: "", baseStat: 0)
        }
        
        return Pokemon(
            id: data.id,
            name: data.name.capitalized,
            height: data.height ?? 0,
            weight: data.weight ?? 0,
            sprite: sprite ?? "",
            type: types,
            stats: stats
        )
    }
    
    func createPokemons(from dataArray: [PokemonGraphQLCallQuery.Data.Pokemon_v2_pokemon]) -> [Pokemon] {
        return dataArray.map { createPokemon(from: $0) }
    }
}
