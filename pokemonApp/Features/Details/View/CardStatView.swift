import SwiftUI

struct CardStatView: View {
    let stat: PokemonStatType
    
    var body: some View {
        HStack {
            Text("\(stat.name)")
            Spacer()
            Text("\(stat.baseStat)")
        }
        
        Divider()
    }
}
