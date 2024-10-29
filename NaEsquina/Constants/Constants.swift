//
//  Constants.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 21/09/24.
//

enum Constants {
    enum PasswordRecovery {
        static let image = "passwordRecovery"
        static let imageDetails = "passwordRecoveryDetails"
        static let mainMessage = "Esqueceu sua senha?"
        static let description = "Não se preocupe! Isso ocorre. Por favor, insira o endereço de e-mail vinculado à sua conta."
    }

    enum OtpVerification {
        static let image = "passwordRecovery"
        static let imageDetails = "passwordRecoveryDetails"
        static let mainMessage = "Verificação de OTP"
        static let description = "Insira o código de verificação que acabamos de enviar em seu endereço de e-mail."
    }

    enum NewPassword {
        static let image = "newPassword"
        static let imageDetails = ""
        static let mainMessage = ""
        static let description = ""
    }

    enum ConfirmEmail {
        static let image = "confirmEmail"
        static let imageDetails = "confirmEmailDetails"
        static let mainMessage = "Verifique seu e-mail"
        static let description = "insira o código de verificação que acabamos de enviar em seu endereço de e-mail."
    }
}
