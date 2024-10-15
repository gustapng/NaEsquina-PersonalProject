//
//  Constants.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 21/09/24.
//

struct Constants {
    struct PasswordRecovery {
        static let image = "passwordRecovery"
        static let imageDetails = "passwordRecoveryDetails"
        static let mainMessage = "Esqueceu sua senha?"
        static let description = "Não se preocupe! Isso ocorre. Por favor, insira o endereço de e-mail vinculado à sua conta."
    }
    
    struct OtpVerification {
        static let image = "passwordRecovery"
        static let imageDetails = "passwordRecoveryDetails"
        static let mainMessage = "Verificação de OTP"
        static let description = "Insira o código de verificação que acabamos de enviar em seu endereço de e-mail."
    }
    
    struct NewPassword {
        static let image = "newPassword"
        static let imageDetails = ""
        static let mainMessage = ""
        static let description = ""
    }
    
    struct ConfirmEmail {
        static let image = "confirmEmail"
        static let imageDetails = "confirmEmailDetails"
        static let mainMessage = "Verifique seu e-mail"
        static let description = "insira o código de verificação que acabamos de enviar em seu endereço de e-mail."
    }

    struct UserOptions {
        struct Option {
            let icon: String
            let title: String
            let subtitle: String
        }

        static let options: [Option] = [
            Option(icon: "info.square", title: "Dados da conta", subtitle: "Minhas informações da conta."),
            Option(icon: "info.square", title: "Sugestões", subtitle: "Tem alguma sugestão? Conte para nós."),
        ]
    }
}
