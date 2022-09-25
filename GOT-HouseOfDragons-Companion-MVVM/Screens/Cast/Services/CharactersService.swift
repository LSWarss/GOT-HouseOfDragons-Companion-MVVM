//
//  CharactersService.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 24/09/2022.
//

import Foundation

enum CharactersError: Error {
    case notFound
}

protocol CharactersService {
    func getCharacters() async throws -> [CharacterState]
    func getCharacter(with id: String) async throws -> CharacterState
}

struct CharactersServiceImpl: CharactersService {
    
    func getCharacters() async throws -> [CharacterState] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return CharacterState.fullCast
    }
    
    func getCharacter(with id: String) async throws -> CharacterState {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        guard let character = CharacterState.fullCast.first(where: { $0.id == id }) else {
            throw CharactersError.notFound
        }
        
        return character
    }
}
