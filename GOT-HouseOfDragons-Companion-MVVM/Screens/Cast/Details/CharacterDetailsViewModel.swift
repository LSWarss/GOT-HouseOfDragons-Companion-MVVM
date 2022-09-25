//
//  CharacterDetailsViewModel.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 24/09/2022.
//

import Foundation

protocol CharacterDetailsViewModel: ObservableObject, BaseViewModel {
    
}

final class CharacterDetailsViewModelImpl: CharacterDetailsViewModel {
    @Published var apiErrorDescription: String?
    @Published var apiError = false
    @Published var isLoading = false
    
    var defaultErrorDescription: String = "Something went wrong"
    var charactersViewModel: CastViewModel
    private let service: CharactersService
    
    init(service: CharactersService,
         charactersViewModel: any CastViewModel) {
        self.service = service
        self.charactersViewModel = charactersViewModel
    }
}
