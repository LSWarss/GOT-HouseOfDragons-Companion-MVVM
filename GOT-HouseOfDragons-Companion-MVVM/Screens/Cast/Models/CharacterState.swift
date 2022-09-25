//
//  Character.swift
//  GOT-HouseOfDragons-Companion-MVVM
//
//  Created by Łukasz Stachnik on 24/09/2022.
//

import Foundation
import ComposableArchitecture

struct CharacterState: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let role: [Role]
    let image: String
    var isDead = false
    
    enum Role: String, Codable {
        case king = "👑"
        case princess = "👸🏼"
        case heir = "👶🏻"
        case handToKing = "✊🏻"
        case queen = "🫅🏼"
        case headOfHouse = "🏰"
        case kingsguard = "💂🏻‍♀️"
        case knight = "🤺"
        case lord = "🗡"
    }
}

enum CharacterAction: Equatable {
    case characterKilled
}

struct CharacterEnvironment {}

let characterReducer = Reducer<CharacterState, CharacterAction, CharacterEnvironment> { state, action, env in
    switch action {
    case .characterKilled:
        state.isDead = true
        return .none
    }
}

extension CharacterState {
    
    static var fullCast: [CharacterState] = [.kingViserys,
                                        .queenAemma,
                                        .princessRhaenyra,
                                        .deamon,
                                        .queenAlice,
                                        .queenRhaenys,
                                        .lordCorlys,
                                        .otto,
                                        .serHarrold,
                                        .criston]
    
    static var kingViserys = CharacterState(id: UUID().uuidString,
                                       name: "Viserys Targaryen",
                                       role: [.king, .headOfHouse],
                                       image: "https://variety.com/wp-content/uploads/2022/08/House-of-the-Dragon-2.jpg?w=1000")
    static var princessRhaenyra = CharacterState(id: UUID().uuidString,
                                            name: "Rhaenyra Targaryen",
                                            role: [.heir, .princess],
                                            image: "https://linkshortner.net/KDlKx")
    static var deamon = CharacterState(id: UUID().uuidString,
                                  name: "Daemon Targaryen",
                                  role: [.heir],
                                  image: "https://variety.com/wp-content/uploads/2022/08/House-of-the-Dragon-9.jpg?w=1000")
    static var otto = CharacterState(id: UUID().uuidString,
                                name: "Otto Hightower",
                                role: [.handToKing],
                                image: "https://variety.com/wp-content/uploads/2022/08/House-of-the-Dragon-8.jpg?w=1000")
    static var queenAlice = CharacterState(id: UUID().uuidString,
                                name: "Alicent Hightower",
                                role: [.queen],
                                image: "https://linkshortner.net/nIsHN")
    static var queenRhaenys = CharacterState(id: UUID().uuidString,
                                        name: "Rhaenys Targaryen",
                                        role: [.queen],
                                        image: "https://variety.com/wp-content/uploads/2022/08/House-of-the-Dragon-13.jpg?w=1110")
    static var lordCorlys = CharacterState(id: UUID().uuidString,
                                      name: "Corlys Velaryon",
                                      role: [.headOfHouse, .lord],
                                      image: "https://variety.com/wp-content/uploads/2022/08/House-of-the-Dragon-12.jpg?w=1000")
    static var queenAemma = CharacterState(id: UUID().uuidString,
                                           name: "Aemma Arryn",
                                      role: [.queen],
                                      image: "https://variety.com/wp-content/uploads/2022/08/House-of-the-Dragon-3.jpg?w=1000")
    static var serHarrold = CharacterState(id: UUID().uuidString,
                                      name: "Harrold Westerling",
                                      role: [.kingsguard, .knight],
                                      image: "https://variety.com/wp-content/uploads/2022/08/House-of-the-Dragon-16.jpg?w=1000")
    static var criston = CharacterState(id: UUID().uuidString,
                                   name: "Criston Cole",
                                   role: [.knight],
                                   image: "https://variety.com/wp-content/uploads/2022/08/fabien-frankel_0.jpg?w=1280")
}


