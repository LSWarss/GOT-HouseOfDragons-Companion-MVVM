//
//  CharacterViewTCA.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 25/09/2022.
//

import SwiftUI
import ComposableArchitecture

struct CharacterViewTCA: View {
    let store: CharacterStore
    
    var body: some View {
        WithViewStore(store) { store in
            HStack {
                buildCharacterImage(for: store.image)
                Text(store.name)
                    .strikethrough(store.isDead,
                                   pattern: .solid,
                                   color: .red)
                
                Spacer()
                
                Button {
                    store.send(.characterKilled)
                } label: {
                    Text("☠️")
                        .font(.title)
                }
            }
            .padding(4)
            .background(.gray)
            .cornerRadius(10)
            .padding(.vertical, 4)
            .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder private func buildCharacterImage(for url: String) -> some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100, maxHeight: 100)
            } else if phase.error != nil {
                Color.red // Indicates an error.
            } else {
                ProgressView()
                    .frame(maxWidth: 100, maxHeight: 100)
            }
        }
    }
}

struct CharacterViewTCA_Previews: PreviewProvider {
    static var previews: some View {
        CharacterViewTCA(store: Store(initialState: CharacterState.criston,
                                      reducer: characterReducer,
                                      environment: CharacterEnvironment()))
    }
}
