//
//  PasswordValidator.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 30/10/24.
//

import Foundation

func isValidPassword(_ password: String) -> Bool {
    let minLength = 8
    let upperCasePattern = ".*[A-Z]+.*"  // pelo menos uma letra maiúscula
    let digitPattern = ".*[0-9]+.*"      // pelo menos um dígito
    let specialCharacterPattern = ".*[!@#$%^&*(),.?\":{}|<>]+.*" // pelo menos um caractere especial

    let lengthValid = password.count >= minLength
    let upperCaseValid = NSPredicate(format: "SELF MATCHES %@", upperCasePattern).evaluate(with: password)
    let digitValid = NSPredicate(format: "SELF MATCHES %@", digitPattern).evaluate(with: password)
    let specialCharacterValid = NSPredicate(format: "SELF MATCHES %@", specialCharacterPattern).evaluate(with: password)

    return lengthValid && upperCaseValid && digitValid && specialCharacterValid
}
