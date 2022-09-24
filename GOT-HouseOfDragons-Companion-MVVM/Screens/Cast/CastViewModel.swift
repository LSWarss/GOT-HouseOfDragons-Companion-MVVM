//
//  CastViewModel.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 24/09/2022.
//

import Foundation

protocol CastViewModel: ObservableObject, BaseViewModel {
    func getCharacters() async
}

final class CastViewModelImpl: CastViewModel {
    @Published var apiErrorDescription: String?
    @Published var apiError = false
    @Published var isLoading = false
    @Published var cast: [Character] = []
    var defaultErrorDescription: String = "Something went wrong"
    private let service: CharactersService
    
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
