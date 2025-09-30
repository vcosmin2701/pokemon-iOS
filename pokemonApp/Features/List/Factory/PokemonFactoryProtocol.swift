import Foundation
import PokeAPI

protocol PokemonFactoryProtocol {
    func createPokemon(from data: PokemonGraphQLCallQuery.Data.Pokemon_v2_pokemon) -> Pokemon
    func createPokemons(from dataArray: [PokemonGraphQLCallQuery.Data.Pokemon_v2_pokemon]) -> [Pokemon]
}
