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
            ZStack {
                if viewStore.state.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEachStore(self.store.scope(state: \.cast, action: CastAction.character(id:action:))) {
                                CharacterViewTCA(store: $0)
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewStore.send(.getCast)
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
