//
//  CastViewModel.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 24/09/2022.
//

import Foundation

protocol CastViewModel: BaseViewModel {
    func getCharacters() async
    
    var presentingCharacterDetails: Bool { get set }
    var selectedCharacter: CharacterState? { get set }
}

final class CastViewModelImpl: CastViewModel, ObservableObject {
    @Published var apiErrorDescription: String?
    @Published var apiError = false
    @Published var isLoading = false
    @Published var cast: [CharacterState] = []
    @Published var presentingCharacterDetails = false
    @Published var selectedCharacter: CharacterState?
    
    var defaultErrorDescription: String = "Something went wrong"
    let service: CharactersService
    
    init(service: CharactersService = CharactersServiceImpl()) {
        self.service = service
    }
    
    func getCharacters() async {
        setLoadingState(true)
        do {
            cast = try await service.getCharacters()
        } catch {
            handleError(nil)
        }
        setLoadingState(false)
    }
    
    func killCharacter(with id: String) {
        guard let characterIndex = cast.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        cast[characterIndex].isDead = true
        cast.sort { !$0.isDead && $1.isDead }
    }
}
