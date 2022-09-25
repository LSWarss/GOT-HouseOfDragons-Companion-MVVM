//
//  CastCore.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 25/09/2022.
//

import Foundation
import ComposableArchitecture

struct CastState: Equatable {
    var cast: [Character]
    var apiError = false
    var isLoading = false
    var apiErrorDescription: String?
}

enum CastAction: Equatable {
    case getCast
    case handleGetCastResponse(TaskResult<[Character]>)
}

// Same as middlewares in other redux like
struct CastEnvironment {
    let charactersService: CharactersService
}

let castReducer = Reducer<CastState, CastAction, CastEnvironment> { state, action, env in
    switch action {
    case .getCast:
        state.isLoading = true
        return .task {
            return await .handleGetCastResponse(TaskResult {
                try await env.charactersService.getCharacters()
            })
        }
    case .handleGetCastResponse(.success(let characters)):
        state.isLoading = false
        state.cast = characters
        return .none
    case .handleGetCastResponse(.failure(let error)):
        state.isLoading = false
        state.apiError = true
        state.apiErrorDescription = error.localizedDescription
        return .none
    }
}
