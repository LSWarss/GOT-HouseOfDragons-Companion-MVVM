//
//  CharacterDetailsScreen.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 24/09/2022.
//

import SwiftUI

struct CharacterDetailsScreen: View {
    @StateObject var viewModel: CharacterDetailsViewModelImpl
    
    var body: some View {
        if let character = viewModel.charactersViewModel.selectedCharacter {
            VStack(spacing: 16) {
                Text(character.name)
                    .font(.title)
                buildCharacterImage(for: character.image)
                HStack {
                    Text("Roles:")
                    
                    ForEach(character.role, id: \.self) { role in
                        Text(role.rawValue)
                    }
                }
                
                if character.isDead {
                    Text("☠️")
                        .font(.title)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    @ViewBuilder private func buildCharacterImage(for url: String) -> some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .clipShape(Capsule())
            } else if phase.error != nil {
                Color.red // Indicates an error.
            } else {
                ProgressView()
                    .frame(maxWidth: 100, maxHeight: 100)
            }
        }
    }
}

struct CharacterDetailsScreen_Previews: PreviewProvider {
    static let castVM = CastViewModelImpl()
    
    static var previews: some View {
        CharacterDetailsScreen(viewModel: CharacterDetailsViewModelImpl(service: CharactersServiceImpl(),
                                                                        charactersViewModel: CastViewModelImpl()))
    }
}
