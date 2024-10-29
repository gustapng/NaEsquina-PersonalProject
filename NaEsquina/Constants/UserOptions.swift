//
//  UserOptions.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 28/10/24.
//

struct Option {
    let icon: String
    let title: String
    let subtitle: String
    let action: String
}

enum UserOptions {
    static let options: [Option] = [
        Option(icon: "info.square",
               title: "Dados da conta",
               subtitle: "Minhas informações da conta.",
               action: "goToUserDataView"),

        Option(icon: "lightbulb",
               title: "Sugestões",
               subtitle: "Tem alguma sugestão? Conte para nós.",
               action: "goToSuggestionView")
    ]
}
