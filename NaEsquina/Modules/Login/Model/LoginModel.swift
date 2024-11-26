//
//  LoginModel.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 24/11/24.
//

struct LoginModel {
    let email: String
    let password: String
    
    var isValid: Bool {
        return !email.isEmpty
            && password.count >= 8
            && isValidPassword(password)
    }

    var validationError: String? {
        if email.isEmpty || password.isEmpty {
            return "Por favor, preencha todos os campos."
        }
        if !isValidPassword(password) {
            return "A senha deve ter pelo menos 8 caracteres, incluindo uma letra maiúscula, uma letra minúscula, um número e um caractere especial."
        }
        return nil
    }
}
