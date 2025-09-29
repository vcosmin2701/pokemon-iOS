import SwiftUI

struct PokemonDetailsView: View {
    @ObservedObject var detailsModel: DetailsViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    detailsModel.toggleFavorite()
                } label: {
                    if detailsModel.isFavoritePokemon{
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }else {
                        Image(systemName: "star")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            AsyncImage(url: URL(string: detailsModel.pokemon.sprite), content: {image in
                image.resizable().frame(width: 200, height: 200)
            }, placeholder: {
                ProgressView()
            })
            
            Text("Name: \(detailsModel.pokemon.name)")
            Text("Height: \(detailsModel.pokemon.height)cm")
            Text("Weight: \(detailsModel.pokemon.weight)kg")
            
            HStack{
                Text("Types: ")
                
                ForEach(detailsModel.pokemon.type, id: \.self) { type in
                    Text("\(type) ")
                }
            }
            
            VStack{
                Divider()
                
                ForEach(detailsModel.pokemon.stats, id: \.self) { stat in
                    CardStatView(stat: stat)
                }
            }
            .padding(.vertical, 4)
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 20)
    }
}

