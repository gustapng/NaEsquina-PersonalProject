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
    let action: (UserCoordinator?) -> Void
}

enum UserOptions {
    static let options: [Option] = [
        Option(icon: "info.square",
               title: "Dados da conta",
               subtitle: "Minhas informações da conta.",
               action: { coordinator in coordinator?.navigateToUserDataView() }),

        Option(icon: "lightbulb",
               title: "Sugestões",
               subtitle: "Tem alguma sugestão? Conte para nós.",
               action: { coordinator in coordinator?.navigateToSuggestionView() })
    ]
    
    static func performAction(at index: Int, using coordinator: UserCoordinator?) {
        guard index < options.count else { return }
        let option = options[index]
        option.action(coordinator)
    }
}
