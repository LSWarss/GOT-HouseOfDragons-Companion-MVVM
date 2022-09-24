//
//  BaseViewModel.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 24/09/2022.
//

import SwiftUI

@MainActor protocol BaseViewModel: AnyObject {
    var defaultErrorDescription: String { get set }
    var apiErrorDescription: String? { get set }
    var apiError: Bool { get set }
    var isLoading: Bool { get set }
    func handleError(_ string: String?)
    func hideError()
    func setLoadingState(_ loadingState: Bool)
}

extension BaseViewModel {
    func handleError(_ string: String?) {
        apiErrorDescription = string ?? defaultErrorDescription
        withAnimation(.spring()) {
            setLoadingState(false)
            apiError = true
        }
    }
    
    func hideError() {
        withAnimation(.spring()) { [weak self] in
            self?.apiError = false
            self?.apiErrorDescription = nil
        }
    }
    
    func setLoadingState(_ loadingState: Bool) {
        withAnimation(.spring()) { [weak self] in
            self?.isLoading = loadingState
        }
    }
}
