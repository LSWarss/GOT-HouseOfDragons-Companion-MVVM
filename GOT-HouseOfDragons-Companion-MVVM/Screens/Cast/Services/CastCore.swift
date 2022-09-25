//
//  CastCore.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 25/09/2022.
//

import Foundation
import ComposableArchitecture

struct CastState: Equatable {
    static func == (lhs: CastState, rhs: CastState) -> Bool {
        lhs.cast == rhs.cast &&
        lhs.apiError == rhs.apiError &&
        lhs.isLoading == rhs.isLoading &&
        lhs.apiErrorDescription == rhs.apiErrorDescription &&
        lhs.showingCharacterDetails == rhs.showingCharacterDetails
    }
    
    var cast: IdentifiedArrayOf<CharacterState> = []
    var apiError = false
    var isLoading = false
    var apiErrorDescription: String?
    
    var showingCharacterDetails = false
    var selectedCharacter: CharacterStore?
}

enum CastAction {
    case getCast
    case handleGetCastResponse(TaskResult<[CharacterState]>)
    case character(id: CharacterState.ID, action: CharacterAction)
    case sortKilledCharacters
    case showCharacter(character: CharacterStore)
    case dismissCharacterSheet
}

// Same as middlewares in other redux like
struct CastEnvironment {
    let charactersService: CharactersService
    
    init(charactersService: CharactersService = CharactersServiceImpl()) {
        self.charactersService = charactersService
    }
}

let castReducer = Reducer<CastState, CastAction, CastEnvironment>.combine(
    characterReducer.forEach(state: \.cast,
                             action: /CastAction.character(id:action:),
                             environment: { _ in
                                 CharacterEnvironment()
                             }
), Reducer { state, action, env in
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
        state.cast = IdentifiedArrayOf(uniqueElements: characters)
        return .none
    case .handleGetCastResponse(.failure(let error)):
        state.isLoading = false
        state.apiError = true
        state.apiErrorDescription = error.localizedDescription
        return .none
    case .sortKilledCharacters:
        state.cast.sort { $1.isDead && !$0.isDead }
        return .none
    case .character(id: _, action: .characterKilled):
        return .task {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            return .sortKilledCharacters
        }
        .animation(.default)
    case .showCharacter(character: let character):
        state.selectedCharacter = character
        state.showingCharacterDetails = true
        return .none
    case .dismissCharacterSheet:
        state.selectedCharacter = nil
        state.showingCharacterDetails = false
        return .none
    }
})
