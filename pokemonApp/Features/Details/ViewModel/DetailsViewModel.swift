import Foundation

class DetailsViewModel: ObservableObject {
    @Published var pokemon: Pokemon
    @Published var favPokemons: [Pokemon] = []
    
    private let defaults = UserDefaults.standard
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        loadFavorites()
    }
    
    var isFavoritePokemon: Bool {
        return favPokemons.contains(where: { $0.id == pokemon.id})
    }
    
    func toggleFavorite() {
        if !isFavoritePokemon {
            addFavorite(pokemon: pokemon)
        }else{
            deleteFavorite(pokemon: pokemon)
        }
    }
    
    private func loadFavorites() {
        if let data = defaults.data(forKey: "SavePokemon") {
            if let decoded = try? JSONDecoder().decode([Pokemon].self, from: data) {
                favPokemons = decoded
            }
        }
    }
    
    private func storePokemon(){
        if let encoded = try? JSONEncoder().encode(favPokemons) {
            defaults.set(encoded, forKey: "SavePokemon")
        }
    }
    
    private func addFavorite(pokemon: Pokemon){
        favPokemons.append(pokemon)
        storePokemon()
    }
    
    private func deleteFavorite(pokemon: Pokemon){
        if let index = favPokemons.firstIndex(where: {$0.id == pokemon.id}) {
            favPokemons.remove(at: index)
        }
        storePokemon()
    }
}
