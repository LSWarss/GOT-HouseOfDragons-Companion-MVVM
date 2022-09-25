//
//  CharacterDetailsScreenTCA.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 25/09/2022.
//

import SwiftUI
import ComposableArchitecture

struct CharacterDetailsScreenTCA: View {
    let store: Store<CharacterState, CharacterAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 16) {
                Text(viewStore.state.name)
                    .font(.title)
                buildCharacterImage(for: viewStore.state.image)
                HStack {
                    Text("Roles:")
                    
                    ForEach(viewStore.state.role, id: \.self) { role in
                        Text(role.rawValue)
                    }
                }
                
                if viewStore.state.isDead {
                    Text("☠️")
                        .font(.title)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    @ViewBuilder private func buildCharacterImage(for url: String) -> some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .clipShape(Capsule())
            } else if phase.error != nil {
                Color.red // Indicates an error.
            } else {
                ProgressView()
                    .frame(maxWidth: 100, maxHeight: 100)
            }
        }
    }
}

struct CharacterDetailsScreenTCA_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsScreenTCA(store: Store(initialState: CharacterState.criston,
                                        reducer: characterReducer,
                                        environment: CharacterEnvironment()))
    }
}
