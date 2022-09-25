//
//  CastScreenTCA.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 25/09/2022.
//

import SwiftUI
import ComposableArchitecture

struct CastScreenTCA: View {
    let store: Store<CastState,CastAction>
    
    var body: some View {
        // A view helper that transforms a Store into a ViewStore so that its state can be observed by a view builder.
        WithViewStore(store) { viewStore in
            LazyVStack(alignment: .leading) {
                ForEach(viewStore.cast) { character in
                    HStack {
                        buildCharacterImage(for: character.image)
                        Text(character.name)
                            .strikethrough(character.isDead,
                                           pattern: .solid,
                                           color: .red)
                        
                        Spacer()
                        
                        Button {
                        
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
            .onAppear {
                viewStore.send(.getCast)
            }
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

struct CastScreenTCA_Previews: PreviewProvider {
    static var previews: some View {
        CastScreenTCA(store: Store(initialState: CastState(),
                                   reducer: castReducer,
                                   environment: CastEnvironment()))
    }
}
