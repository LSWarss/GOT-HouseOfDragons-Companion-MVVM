//
//  GOT_HouseOfDragons_Companion_MVVMApp.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 24/09/2022.
//

import SwiftUI
import ComposableArchitecture

@main
struct GOT_HouseOfDragons_Companion_MVVMApp: App {
    var body: some Scene {
        WindowGroup {
            CastScreenTCA(store: Store(initialState: CastState(),
                                       reducer: castReducer.debug(),
                                       environment: CastEnvironment()))
        }
    }
}
