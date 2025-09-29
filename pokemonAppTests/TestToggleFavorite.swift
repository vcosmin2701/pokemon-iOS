import XCTest
@testable import pokemonApp

final class TestToggleFavorite: XCTestCase {
    var viewModel: DetailsViewModel!
    var samplePokemon: Pokemon!
    
    override func setUpWithError() throws {
        samplePokemon = Pokemon(id: 6, name: "Charizard", height: 17, weight: 905, sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png", type: ["fire"], stats: [])
        viewModel = DetailsViewModel(pokemon: samplePokemon)
        
        UserDefaults.standard.removeObject(forKey: "SavePokemon")
    }
    
    func testToggleFavorite_AddsPokemonToFavorite() {
        XCTAssertFalse(viewModel.isFavoritePokemon)
        viewModel.toggleFavorite()
        print("Favorites after toggle:", viewModel.favPokemons)

        XCTAssertTrue(viewModel.favPokemons.contains(where: { $0.id == samplePokemon.id }))
    }
    
}
