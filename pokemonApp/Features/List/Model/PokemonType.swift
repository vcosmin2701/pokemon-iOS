import Foundation

struct Pokemon: Identifiable, Hashable, Codable{
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprite: String
    let type: [String]
    let stats: [PokemonStatType]
}
