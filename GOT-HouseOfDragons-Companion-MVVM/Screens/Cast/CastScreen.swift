//
//  ContentView.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 24/09/2022.
//

import SwiftUI


struct CastScreen: View {
    @StateObject var viewModel: CastViewModelImpl
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.cast) { character in
                    HStack {
                        buildCharacterImage(for: character.image)
                        Text(character.name)
                            .strikethrough(character.isDead,
                                           pattern: .solid,
                                           color: .red)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                viewModel.killCharacter(with: character.id)
                            }
                        } label: {
                            Text("☠️")
                                .font(.title)
                        }
                    }
                    .padding(4)
                    .background(.gray)
                    .cornerRadius(10)
                    .onTapGesture {
                        viewModel.selectedCharacter = character
                        viewModel.presentingCharacterDetails = true
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 16)
                }
            }
        }
        .task {
            await viewModel.getCharacters()
        }
        .sheet(isPresented: $viewModel.presentingCharacterDetails) {
            CharacterDetailsScreen(viewModel: CharacterDetailsViewModelImpl(service: viewModel.service,
                                                                            charactersViewModel: viewModel))
        }
    }
    
    @ViewBuilder private func buildCharacterImage(for url: String) -> some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100, maxHeight: 100)
            } else if phase.error != nil {
                Color.red // Indicates an error.
            } else {
                ProgressView()
                    .frame(maxWidth: 100, maxHeight: 100)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CastScreen(viewModel: CastViewModelImpl())
    }
}
